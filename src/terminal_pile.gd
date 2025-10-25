class_name TerminalPile
extends MarginContainer

@export var suit: CardData.Suit
@onready var cards: Control = %Cards

var _cards: Array[Card] = []

func try_add(card: Card):
	var top_card = get_top_card()
	
	var required_value:int = top_card.card_data.value+1 if top_card != null else 1
	
	return card.card_data.suit == suit && card.card_data.value == required_value

func add(card: Card):
	if !try_add(card):
		push_warning("Trying to add %s, but it's impossible" % [card])
	
	_cards.push_back(card)
	cards.add_child(card)

func grab_card() -> Card:
	var card_to_grab = get_top_card()
	
	if (card_to_grab != null):
		_cards.pop_back()
	
	return card_to_grab

func get_top_card() -> Card:
	if _cards.is_empty():
		return null
	return _cards[-1]
