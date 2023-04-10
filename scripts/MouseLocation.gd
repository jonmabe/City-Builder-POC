extends Label

var main_node = null
var camera = null

func _ready():
	main_node = get_node("/root/Main")
	camera = get_node("/root/Main/MainCamera")

	var screen_size = get_viewport_rect().size
	rect_position = Vector2(0, screen_size.y - rect_size.y - 60)

	# Connect to the mouse moved signal
	set_process(true)

func _process(delta):
	# Get the current mouse position
	var viewport_mouse_pos = get_viewport().get_mouse_position() 
	var translated_pos = main_node.mouse_position_to_isometric_grid(viewport_mouse_pos)
	
	# Update the label text with the tile coordinates
	text = "Mouse position: " + str(viewport_mouse_pos) + "\nTranslated position: " + str(translated_pos)
