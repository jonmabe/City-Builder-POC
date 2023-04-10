extends Timer

onready var time_label = get_node("/root/Main/UI/TimeLabel")
onready var main_node = get_node("/root/Main")
var in_game_hours: int = 0
var in_game_days: int = 0
var is_running = false


func _ready():
	wait_time = 1
	autostart = true
	is_running = true
	connect("timeout", self, "_on_timeout")

func _on_timeout():
	in_game_hours += 1
	if in_game_hours >= 24:
		in_game_hours = 0
		in_game_days += 1
	update_time_label()
	
	main_node.destroy_random_building()
	#main_node.clear_city()
	#main_node.generate_city()

func update_time_label():
	time_label.text = "In-game time: Day " + str(in_game_days) + " Hour " + str(in_game_hours)

func pause_game():
	is_running = false
	stop()

func resume_game():
	is_running = true
	start()

func toggle_pause():
	if is_running:
		pause_game()
	else:
		resume_game()
