extends Node2D

# Enums
enum GroundType {DIRT}

var GroundMeta = {
	GroundType.DIRT: {
		"name": "DIRT"
	}
}

# Exported variables
export(GroundType) var ground_type
export(int) var build_cost = 0

# Nodes
onready var sprite = $Sprite

# Building textures
const TEXTURES = {
	GroundType.DIRT: preload("res://assets/images/MBS_Isometric_City_Pack/Grounds + Roads/ground_dirt.png"),
}

func _ready():
	update_texture()

#func update_texture():
#	sprite.texture = TEXTURES[building_type]
# Inside Building.gd
# Inside Building.gd
func update_texture():
	#if building_type >= 0 and building_type < BuildingType.MAX_BUILDING_TYPE:
	$Sprite.texture = TEXTURES[ground_type]

