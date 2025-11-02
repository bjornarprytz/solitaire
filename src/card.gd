class_name Card
extends CanvasItem

var grab_context_factory = preload("res://grab_context.tscn")

@export var card_data: CardData

@onready var value_1: RichTextLabel = %Value1
@onready var value_2: RichTextLabel = %Value2
@onready var suit: TextureRect = %Suit

@onready var front: TextureRect = %Front
@onready var back: TextureRect = %Back

var is_face_down: bool = false
var is_shaking: bool = false

func _ready() -> void:
	value_1.text = card_data.value_as_string()
	value_2.text = card_data.value_as_string()
	front.modulate = card_data.suit_as_color()
	suit.texture = card_data.suit_as_icon()
	
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

func highlight():
	modulate = Color.CHARTREUSE

func unhighlight():
	modulate = Color.WHITE

func _on_input_catcher_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if is_face_down:
			return
		
		match (event.button_index):
			MOUSE_BUTTON_LEFT:
				var grab_context = grab_context_factory.instantiate() as GrabContext
				get_tree().root.add_child(grab_context)
				
				var cards: Array[Card] = [self]
				
				var passed_self = false
				for card in self.get_parent().get_children():
					if card == self:
						passed_self = true
					elif card is Card and passed_self:
						cards.push_back(card)
				
				grab_context.grab(cards)
			MOUSE_BUTTON_RIGHT:
				Events.try_move_to_terminal.emit(self)

func shake():
	if (is_shaking):
		return
	is_shaking = true
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 2.0, .069).as_relative()
	tween.tween_property(self, "rotation_degrees", -4.0, .069).as_relative()
	tween.tween_property(self, "rotation_degrees", 3.0, .069).as_relative()
	tween.tween_property(self, "rotation_degrees", -1.0, .069).as_relative()
	await tween.finished
	is_shaking = false

func _on_input_catcher_mouse_entered() -> void:
	shake()
