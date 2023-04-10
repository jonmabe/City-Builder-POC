extends Control

const Building = preload("res://scripts/Building.gd")

var mouse_position = Vector2.ZERO
var is_dragging = false

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var main_node = get_node("/root/Main")
			main_node.place_building_mouse(event.position, main_node.selected_building_type)
