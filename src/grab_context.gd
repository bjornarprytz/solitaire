class_name GrabContext
extends Node2D

@onready var grabbed_cards: VBoxContainer = %Cards

var _previous_parent: CanvasItem

func _ready() -> void:
	var t = create_tween()
	t.tween_method(tween_separation, grabbed_cards.get("theme_override_constants/separation"), -104, .069)

func tween_separation(separation: int):
	grabbed_cards.set("theme_override_constants/separation", separation)

func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and !event.is_pressed()):
		try_drop()

func try_drop():
	process_mode = Node.PROCESS_MODE_DISABLED
	var space = get_world_2d().direct_space_state
	var mouse_pos = get_global_mouse_position()
	var args = PhysicsPointQueryParameters2D.new()
	args.position = mouse_pos
	args.collide_with_areas = true
	var result = space.intersect_point(args)
	if result:
		if result[0].collider.owner is Droppable:
			var cards: Array[Card] = []
			for card in grabbed_cards.get_children():
				if card is Card:
					cards.push_back(card)
			result[0].collider.owner.drop_cards(cards)
	cancel()

func grab(cards: Array[Card]) -> void:
	if (cards.size() == 0):
		cancel()
		return
	
	_previous_parent = cards[0].get_parent()
	for card in cards:
		card.reparent(grabbed_cards)

func cancel():
	assert(_previous_parent != null, "Nowhere to return the cards to :(")
	
	for card in grabbed_cards.get_children():
		var dest = CardDestination.new()
		_previous_parent.add_child(dest)
		await dest.add_card(card)
	
	queue_free()
