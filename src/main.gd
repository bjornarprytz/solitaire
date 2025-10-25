extends Node2D
@onready var title_2: RichTextLabel = $CanvasLayer/PanelContainer/MarginContainer/VBoxContainer/Title2

	
func _ready() -> void:
	# await next frame
	await get_tree().process_frame
	
	var tween = create_tween().set_trans(Tween.TRANS_CIRC)
	
	title_2.pivot_offset = title_2.size / 2
	tween.tween_property(title_2, "rotation_degrees", 6.9, .069).as_relative()
	tween.tween_property(title_2, "rotation_degrees", -6.9, .069).as_relative()
	tween.set_loops(2)
	
	
	await tween.finished
