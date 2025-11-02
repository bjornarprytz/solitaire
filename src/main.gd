extends Node2D

var card_spawner = preload("res://card.tscn")
var bounce_harness_spawner = preload("res://bounce_harness.tscn")

@onready var stack_piles: Array[StackPile] = [%StackPile1, %StackPile2, %StackPile3, %StackPile4, %StackPile5, %StackPile6, %StackPile7]
@onready var open_pile: OpenPile = %OpenPile
@onready var draw_pile: DrawPile = %DrawPile

@onready var terminals: Array[TerminalPile] = [%HeartsTerminal, %ClubsTerminal, %DiamondsTerminal, %SpadesTerminal]

var _cards: Array[Card] = []

func _ready() -> void:
	var cards: Array[Card] = []
	for suit in CardData.each_suit():
		for value in CardData.each_value():
			var card = card_spawner.instantiate() as Card
			card.card_data = CardData.new()
			card.card_data.suit = suit
			card.card_data.value = value
			
			cards.push_back(card)
			_cards.push_back(card)
	cards.shuffle()

	for i in range(stack_piles.size()):
		var pile = stack_piles[i]

		var face_down_cards: Array[Card] = []
		for j in range(i):
			var card = cards.pop_back()
			face_down_cards.push_back(card)
		var face_up_card = cards.pop_back()
		
		pile.initialize(face_down_cards, face_up_card)
	
	draw_pile.add_cards(cards)
	
	Events.terminal_pile_updated.connect(check_game_over)

func check_game_over():
	for terminal in terminals:
		if (terminal.stack.get_child_count() != 13):
			return
	Events.game_over.emit(true)
	
	win_effect()

func win_effect():
	await get_tree().process_frame
	for card in _cards:
		var harness = bounce_harness_spawner.instantiate() as RigidBody2D
		get_tree().root.add_child(harness)
		harness.global_position = card.global_position
		card.reparent(harness)
		
		harness.inertia = .69
		harness.apply_torque_impulse(randf_range(-.69, .69))
		harness.apply_impulse(Vector2.UP.rotated(randf_range(-PI, PI)) * randf_range(690, 969))
	
	
