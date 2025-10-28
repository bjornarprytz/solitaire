class_name TerminalPile
extends Droppable

@export var suit: CardData.Suit
@onready var stack: Control = %Cards
@onready var suit_icon: TextureRect = %Suit

func _ready() -> void:
	suit_icon.texture =  CardData.suit_to_icon(suit)
	suit_icon.modulate = CardData.suit_to_color(suit)
	
	Events.try_move_to_terminal.connect(add)

func try_add(card: Card):
	var top_card = get_top_card()
	
	var required_value:int = top_card.card_data.value+1 if top_card != null else 1
	
	return card.card_data.suit == suit && card.card_data.value == required_value

func add(card: Card):
	if !try_add(card):
		return
	
	if card.get_parent() != null:
		card.reparent(stack)
	else:
		stack.add_child(card)
	card.position = Vector2.ZERO
	
	Events.terminal_pile_updated.emit()

func grab_card() -> Card:
	var card_to_grab = get_top_card()
	
	return card_to_grab

func get_top_card() -> Card:
	if stack.get_child_count() == 0:
		return null
	return stack.get_child(-1)

func drop_cards(cards: Array[Card]) -> bool:
	if cards.size() != 1:
		return false
	
	if try_add(cards[0]):
		add(cards[0])
	
	return true
