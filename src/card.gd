@tool
class_name Card
extends CanvasItem

@export var card_data: CardData

@onready var value_1: RichTextLabel = %Value1
@onready var value_2: RichTextLabel = %Value2

@onready var front: TextureRect = %Front
@onready var back: TextureRect = %Back

var is_face_down: bool = false

func _ready() -> void:
	value_1.text = card_data.value_as_string()
	value_2.text = card_data.value_as_string()
	front.modulate = card_data.suit_as_color()
	
	if is_face_down:
		front.hide()
		back.show()
	else:
		front.show()
		back.hide()
	

func _to_string() -> String:
	return "%s %s" % [card_data.value_as_string(), card_data.suit]


func flip_over():
	is_face_down = !is_face_down
	
	var tween = create_tween()
	
	tween.tween_property(self, "scale:x", 0.0, .069)
	if (is_face_down):
		tween.tween_callback(front.hide)
		tween.tween_callback(back.show)
	else:
		tween.tween_callback(front.show)
		tween.tween_callback(back.hide)
	tween.tween_property(self, "scale:x", 1.0, .069)
	
	await tween.finished


func _on_input_catcher_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		flip_over()
