@tool
class_name CardData
extends Resource

enum Suit{
	Hearts,
	Clubs,
	Diamonds,
	Spades
}

@export_range(1, 13) var value: int
@export var suit : Suit

func value_as_string() -> String:
	match (value):
		1:
			return "A"
		11:
			return "J"
		12: 
			return "Q"
		13:
			return "K"
		_:
			return str(value)

func suit_as_color() -> Color:
	if [Suit.Hearts, Suit.Diamonds].has(suit):
		return Color.ORANGE_RED
	else:
		return Color.AQUA

func suit_as_icon() -> Texture:
	return preload("res://icon.svg")
