class_name DrawPile
extends CanvasItem

@onready var count_label: RichTextLabel = %Count
@onready var hidden_cards: Node2D = %HiddenCards

@onready var count : int:
	set(value):
		count = value
		count_label.text = str(count)

func add_cards(cards: Array[Card]):	
	for card in cards:
		if (card.get_parent() == null):
			hidden_cards.add_child(card)
		else:
			card.reparent(hidden_cards)
	count = hidden_cards.get_child_count()

func get_card() -> Card:
	if hidden_cards.get_child_count() == 0:
		return null
	
	return hidden_cards.get_child(-1)
	
