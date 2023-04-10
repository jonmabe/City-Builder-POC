extends Node2D


# Constants
const BUILD_MODE = 0
const RESOURCE_MODE = 1

# Variables
var mode = BUILD_MODE

onready var buildings: Array = []
onready var game_timer = $GameTimer
onready var event_stream = $UI/EventStream
onready var main_camera = $MainCamera
var main_node

const Building = preload("res://scripts/Building.gd")
const Ground = preload("res://scripts/Ground.gd")
const CITY_SIZE = Vector2(10, 10)
const TILE_SIZE = Vector2(132, 68)
onready var building_scene = preload("res://scenes/Building.tscn")
onready var ground_scene = preload("res://scenes/Ground.tscn")

func _ready():	
	randomize()
	generate_grid()
	generate_city()
	center_viewport()
	update()

func center_viewport():
	var used_area = CITY_SIZE * TILE_SIZE
	var center = Vector2(0, used_area.y / 2 - TILE_SIZE.y/2)	
	main_camera.center(center)
	pass

func mouse_position_to_isometric_grid(viewport_mouse_pos):
	var viewport_size = get_viewport().size
	var camera_pos = main_camera.get_camera_screen_center()
	var normalized_pos = ((viewport_mouse_pos - (viewport_size / 2)) * main_camera.zoom) + camera_pos
	
	var x = normalized_pos.x
	var y = normalized_pos.y + TILE_SIZE.y/2
	
	var grid_x = (y / TILE_SIZE.y + x / TILE_SIZE.x)
	var grid_y = (y / TILE_SIZE.y - x / TILE_SIZE.x)
	
	return Vector2( int(floor(grid_x)),  int(floor(grid_y)))

func generate_grid():
	for x in range(CITY_SIZE.x):
		for y in range(CITY_SIZE.y):
			var grid_position = Vector2(x, y)
			var ground_type = Ground.GroundType.DIRT
			place_ground_at(grid_position, ground_type)
	pass
	
func place_ground_at(grid_position, ground_type): 
	var ground = ground_scene.instance()
	var world_position = Vector2(
		(grid_position.x - grid_position.y) * (TILE_SIZE.x / 2),
		(grid_position.x + grid_position.y) * (TILE_SIZE.y / 2)
	)

	ground.ground_type = ground_type
	ground.update_texture()
	ground.position = world_position

	add_child(ground)

func generate_city():	
	  # Set the size of the city
	var building_density = 0.2  # The probability of placing a building in a given tile (between 0 and 1)
	for x in range(CITY_SIZE.x):
		for y in range(CITY_SIZE.y):
			var grid_position = Vector2(x, y)
			if randf() < building_density:
				# Randomly choose a building type
				var building_type = randi() % (Building.BuildingType.RESEARCH_CENTER + 1)
				# Place the building at the current grid position
				place_building_at(grid_position, building_type)
				
	event_stream.add_message("City generated")

func clear_city():
	#var buildings = main.buildings
	for x in range(len(buildings)):
		var building_to_destroy = buildings[x]
		building_to_destroy.queue_free()
	buildings.clear()
	event_stream.add_message("City cleared")

func is_valid_building_position(grid_position):
	#Check if in the map
	if (grid_position.x < 0 or grid_position.x >= CITY_SIZE.x or
		grid_position.y < 0 or grid_position.y >= CITY_SIZE.y):
		return false
	
	# Check for existing buildings
	for child in get_children():
		if child is Building:
			if child.grid_position == grid_position:
				return false

	# Add any other conditions to validate the building position
	# Example: Check if the position is on land, water, etc.

	# If no conditions are met, the position is valid
	return true

func place_building_mouse(mouse_position, building_type):
	var grid_pos = mouse_position_to_isometric_grid(mouse_position)
	place_building_at(grid_pos, building_type)

func place_building_at(grid_position, building_type):
	if is_valid_building_position(grid_position):
		var building = building_scene.instance()
		var world_position = Vector2(
			(grid_position.x - grid_position.y) * (TILE_SIZE.x / 2),
			(grid_position.x + grid_position.y) * (TILE_SIZE.y / 2)
		)
		building.building_type = building_type
		building.grid_position = grid_position
		building.update_texture()
		
		building.z_index = grid_position.x + grid_position.y
		building.position = world_position + building.get_texture_offset(TILE_SIZE)  # Adjust the Y offset as needed
		
		add_child(building)
		buildings.append(building)
		event_stream.add_message("Building "+ building.BuildingMeta[building_type]["name"] +" added")


func destroy_random_building():
	if len(buildings) > 0:
		var random_building_index = randi() % len(buildings)
		var building_to_destroy = buildings[random_building_index]
		building_to_destroy.queue_free()
		buildings.remove(random_building_index)
		event_stream.add_message("Building destroyed")


func build_random_building():
	var grid_position = Vector2(randi() % int(CITY_SIZE.x), randi() % int(CITY_SIZE.y))
	# Randomly choose a building type
	var building_type = randi() % (Building.BuildingType.RESEARCH_CENTER + 1)
	# Place the building at the current grid position
	place_building_at(grid_position, building_type)
