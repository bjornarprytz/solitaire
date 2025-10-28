class_name CardData
extends Resource

enum Suit {
	Hearts,
	Clubs,
	Diamonds,
	Spades
}
const CLUBS_TEXTURE = preload("uid://bybk6t6lgpl52")
const DIAMONDS_TEXTURE = preload("uid://cuy0ynuvhy4uu")
const HEARTS_TEXTURE = preload("uid://cwbgtq6075gv3")
const SPADES_TEXTURE = preload("uid://c55llxj3bfyi")

@export_range(1, 13) var value: int
@export var suit: Suit

func _init(suit_: Suit, value_: int) -> void:
	suit = suit_
	value = value_

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
	return suit_to_color(suit)

func suit_as_icon() -> Texture:
	return suit_to_icon(suit)

static func suit_to_color(suit_: Suit) -> Color:
	if [Suit.Hearts, Suit.Diamonds].has(suit_):
		return Color.ORANGE_RED
	else:
		return Color.AQUA

static func suit_to_icon(suit_: Suit) -> Texture:
	match suit_:
		Suit.Hearts:
			return HEARTS_TEXTURE
		Suit.Clubs:
			return CLUBS_TEXTURE
		Suit.Diamonds:
			return DIAMONDS_TEXTURE
		Suit.Spades:
			return SPADES_TEXTURE
	
	return preload("res://icon.svg")
	

static func each_value() -> Array:
	return range(1, 14)

static func each_suit() -> Array[Suit]:
	return [Suit.Hearts, Suit.Clubs, Suit.Diamonds, Suit.Spades]
