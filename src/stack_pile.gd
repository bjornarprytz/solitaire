class_name StackPile
extends VBoxContainer

@onready var face_down: VBoxContainer = %FaceDown
@onready var face_up: VBoxContainer = %FaceUp

func initialize(face_down_cards: Array[Card], face_up_card: Card):
	for card in face_down_cards:
		card.is_face_down = true
		face_down.add_child(card)
	
	if (face_down_cards.size() > 0):
		face_down.show()
	
	face_up_card.is_face_down = false
	face_up.add_child(face_up_card)

func can_flip_card() -> bool:
	if (face_up.get_child_count() > 0):
		return false
	
	return face_down.get_child_count() > 0

func flip_card():
	if (!can_flip_card()):
		push_warning("Trying to flip card on stack, but it's impossible!")
		return
	var card_to_flip = face_down.get_child(-1) as Card
	
	card_to_flip.reparent(face_up)
	card_to_flip.flip_over()
	if face_down.get_child_count() == 0:
		face_down.hide()
	

func can_add(card: Card) -> bool:
	# Abort if face-down card can be flipped
	if (can_flip_card()):
		return false
	
	var top_card = get_top_card()
	
	# Require a decrement or 13 on an empty stack
	var required_value:int = top_card.card_data.value-1 if top_card != null else 13
	
	# Require alternating colors
	if (top_card.card_data.suit_as_color() == card.card_data.suit_as_color()):
		return false
	
	return card.card_data.value == required_value

func add(top_card: Card, sub_stack: Array[Card]):
	if !can_add(top_card):
		push_warning("Trying to add %s, but it's impossible" % [top_card])
		return
	# Assume the sub_stack is valid
	
	face_up.add_child(top_card)
	
	for card in sub_stack:
		face_up.add_child(card)

func get_top_card() -> Card:
	if face_up.get_child_count() == 0:
		return null
	return face_up.get_child(-1)
