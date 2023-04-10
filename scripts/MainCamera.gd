extends Camera2D

var zoom_min = Vector2(.2, .2)
var zoom_max = Vector2(.2, .2)
var zoom_speed = Vector2(.1, .1)

var is_dragging = false
var last_mouse_position = Vector2.ZERO

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_MIDDLE:
		if event.is_pressed():
			is_dragging = true
			last_mouse_position = event.position
		else:
			is_dragging = false

	if event is InputEventMouseMotion and is_dragging:
		var delta = last_mouse_position - event.position
		set_offset(get_offset() + delta * zoom)
		last_mouse_position = event.position

	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP:
		var zoom_point = get_global_mouse_position()
		var new_zoom = zoom - zoom_speed
		if true || new_zoom.x > zoom_min.x and new_zoom.y > zoom_min.y:
			set_zoom(new_zoom)
			var zoom_offset = zoom_point / zoom - get_global_mouse_position() / zoom
			set_offset(get_offset() + zoom_offset)

	elif event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN:
		var zoom_point = get_global_mouse_position()
		var new_zoom = zoom + zoom_speed
		if true || new_zoom.x < zoom_max.x and new_zoom.y < zoom_max.y:
			set_zoom(new_zoom)
			var zoom_offset = zoom_point / zoom - get_global_mouse_position() / zoom
			set_offset(get_offset() + zoom_offset)

func center(center):
	set_offset(center)	
