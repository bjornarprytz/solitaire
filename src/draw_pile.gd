class_name DrawPile
extends TextureRect

@onready var count_label: RichTextLabel = %Count

@onready var count : int:
	set(value):
		count = value
		count_label.text = str(count)

func _ready() -> void:
	count = 15
		
