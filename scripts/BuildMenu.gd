extends Control

signal building_selected(building_type)

const Building = preload("res://scripts/Building.gd")

onready var vbox_container = $VBoxContainer

func _ready():
	generate_build_buttons()

func generate_build_buttons():
	var building_types = Building.BuildingMeta

	for building_type in building_types:
		var building_info = Building.BuildingMeta[building_type]
		var button = Button.new()
		button.text = building_info["name"]
		button.name = building_info["name"]
		button.connect("pressed", self, "_on_build_button_pressed", [building_type])
		button.set_meta("building_type", building_type)
		button.rect_min_size = Vector2(150, 40) # You can set the button size here
		button.add_to_group("build_button")
		vbox_container.add_child(button)

func _on_build_button_pressed(building_type):
	print("Building selected: " + str(building_type))
	emit_signal("building_selected", building_type)
