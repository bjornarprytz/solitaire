class_name OpenPile
extends CanvasItem
@onready var card_parent: Control = %Cards

func _ready() -> void:
	Events.draw_card.connect(on_draw)
	Events.draw_pile_empty.connect(on_draw_pile_empty)
	
func on_draw(card: Card):
	card.reparent(card_parent)
	card.position = Vector2.ZERO
	
func on_draw_pile_empty(draw_pile: DrawPile):
	var cards: Array[Card] = []
	
	for card in card_parent.get_children():
		if card is Card:
			cards.push_front(card)
	
	draw_pile.add_cards(cards)
