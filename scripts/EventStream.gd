extends RichTextLabel

func _ready():
	# Get the size of the viewport
	var viewport_size = get_viewport_rect().size

	# Set the size of the node to 20% of the width and 10% of the height of the viewport
	rect_size = Vector2(viewport_size.x * 0.2, viewport_size.y * 0.1)

	# Set the position of the node to the top right corner of the viewport
	rect_position = Vector2(viewport_size.x * 0.8, 0)


func add_message(message):
	# Add the message to the label text
	add_text(message + "\n")

	# Scroll the text to the bottom
	scroll_to_line(get_line_count() - 1)
