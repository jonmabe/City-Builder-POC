extends Camera2D

var zoom_min = Vector2(.2, .2)
var zoom_max = Vector2(3, 3)
var zoom_speed = Vector2(.1, .1)

var is_dragging = false
var last_mouse_position = Vector2.ZERO
var last_touch_position = Vector2.ZERO

var touch_zoom_begin_distance = -1.0
var touch_zoom_begin_zoom = Vector2.ZERO
var touch_zoom_begin_offset = Vector2.ZERO

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

	if event is InputEventScreenTouch:
		if event.is_pressed():
			is_dragging = true
			last_touch_position = event.position
		else:
			is_dragging = false
			touch_zoom_begin_distance = -1.0

	if event is InputEventScreenDrag and is_dragging:
		var delta = last_touch_position - event.position
		set_offset(get_offset() + delta * zoom)
		last_touch_position = event.position

	if event is InputEventScreenTouch and event.is_pressed():
		var touch_points = get_viewport().get_touches()
		if touch_points.size() == 2:
			touch_zoom_begin_distance = touch_points[0].distance_to(touch_points[1])
			touch_zoom_begin_zoom = zoom
			touch_zoom_begin_offset = get_offset()

	if touch_zoom_begin_distance != -1.0:
		var touch_points = get_viewport().get_touches()
		if touch_points.size() == 2:
			var current_distance = touch_points[0].distance_to(touch_points[1])
			var zoom_ratio = current_distance / touch_zoom_begin_distance
			var new_zoom = touch_zoom_begin_zoom * zoom_ratio

			new_zoom.x = clamp(new_zoom.x, zoom_min.x, zoom_max.x)
			new_zoom.y = clamp(new_zoom.y, zoom_min.y, zoom_max.y)

			set_zoom(new_zoom)

			var focal_point = (touch_points[0] + touch_points[1]) / 2.0
			var focal_point_global = get_global_transform().affine_inverse().xform(focal_point)
			var focal_point_ratio = (focal_point_global - get_global_position()) * (1.0 - zoom_ratio)
			set_offset(touch_zoom_begin_offset - focal_point_ratio)
func center(center):
	set_offset(center)	
