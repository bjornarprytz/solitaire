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

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var top_card = get_card()
		if (top_card == null):
			Events.draw_pile_empty.emit(self)
		else:
			Events.draw_card.emit(top_card)
			count = hidden_cards.get_child_count()
