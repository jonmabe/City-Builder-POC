extends Node2D

# Enums
enum BuildingType {HOUSE, FARM, MINE, FACTORY, RESEARCH_CENTER}

const BuildingMeta = {
	BuildingType.HOUSE: {
		"name": "HOUSE"
	},
	BuildingType.FARM: {
		"name": "FARM"
	},
	BuildingType.MINE: {
		"name": "MINE"
	},
	BuildingType.FACTORY: {
		"name": "FACTORY"
	},
	BuildingType.RESEARCH_CENTER: {
		"name": "RESEARCH_CENTER"
	},
}

# Exported variables
export(BuildingType) var building_type
export(int) var build_cost = 0
export(Vector2) var grid_position = Vector2(-1,-1)

# Nodes
onready var sprite = $Sprite

# Building textures
const TEXTURES = {
	BuildingType.HOUSE: preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/house_large_brown_a.png"),
	BuildingType.FARM: preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/barn_red_a.png"),
	BuildingType.MINE: preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/warehouse_maroon_a.png"),
	BuildingType.FACTORY: preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/building_small_brown_b.png"),
	BuildingType.RESEARCH_CENTER: preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/hospital_a.png"),
}

func _ready():
	update_texture()

#func update_texture():
#	sprite.texture = TEXTURES[building_type]
# Inside Building.gd
# Inside Building.gd
func update_texture():
	#if building_type >= 0 and building_type < BuildingType.MAX_BUILDING_TYPE:
	$Sprite.texture = TEXTURES[building_type]

func get_texture_offset(grid_size):
	var size = $Sprite.texture.get_size()
	var difference = size - grid_size
	return Vector2(difference.x / 2 + 3, difference.y / 2 * -1 + 3)

func get_build_cost():
	return build_cost

