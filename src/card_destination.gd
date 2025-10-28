class_name CardDestination
extends Control

func add_card(card: Card):
	if (card.get_parent() == null):
		add_child(card)
	else:
		card.reparent(self)
	
	var tween = create_tween()
	tween.tween_property(card, "position", Vector2.ZERO, .069)
	await tween.finished
	card.reparent(self.get_parent())
	queue_free()
	
