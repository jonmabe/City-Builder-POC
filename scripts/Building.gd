extends Node2D

const ColonyResource = preload("res://scripts/ColonyResource.gd")

# Enums
enum BuildingType {HOUSE, FARM, MINE, FACTORY, RESEARCH_CENTER}

const BuildingMeta = {
	BuildingType.HOUSE: {
		"name": "HOUSE",
		"texture": preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/house_large_brown_a.png"),
		"costs": {
			ColonyResource.ResourceType.FOOD: 20,
			ColonyResource.ResourceType.WATER: 100,
			ColonyResource.ResourceType.ENERGY: 50,
			ColonyResource.ResourceType.MINERALS: 200
		},
		"hourly_resources_generated": {
			ColonyResource.ResourceType.POPULATION: 10
		},
	},
	BuildingType.FARM: {
		"name": "FARM",
		"texture": preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/barn_red_a.png"),
		"costs": {
			ColonyResource.ResourceType.FOOD: 20,
			ColonyResource.ResourceType.WATER: 100,
			ColonyResource.ResourceType.ENERGY: 50,
			ColonyResource.ResourceType.MINERALS: 200
		},
		"hourly_resources_generated": {
			ColonyResource.ResourceType.FOOD: 10
		}
	},
	BuildingType.MINE: {
		"name": "MINE",
		"texture": preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/warehouse_maroon_a.png"),
		"costs": {
			ColonyResource.ResourceType.FOOD: 20,
			ColonyResource.ResourceType.WATER: 100,
			ColonyResource.ResourceType.ENERGY: 50,
			ColonyResource.ResourceType.MINERALS: 200
		},
		"hourly_resources_generated": {
			ColonyResource.ResourceType.MINERALS: 10
		}
	},
	BuildingType.FACTORY: {
		"name": "FACTORY",
		"texture": preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/building_small_brown_b.png"),
		"costs": {
			ColonyResource.ResourceType.FOOD: 20,
			ColonyResource.ResourceType.WATER: 100,
			ColonyResource.ResourceType.ENERGY: 50,
			ColonyResource.ResourceType.MINERALS: 200
		},
		"hourly_resources_generated": {
			ColonyResource.ResourceType.ENERGY: 10
		}
	},
	BuildingType.RESEARCH_CENTER: {
		"name": "RESEARCH_CENTER",
		"texture": preload("res://assets/images/MBS_Isometric_City_Pack/Buildings/hospital_a.png"),
		"costs": {
			ColonyResource.ResourceType.FOOD: 20,
			ColonyResource.ResourceType.WATER: 100,
			ColonyResource.ResourceType.ENERGY: 50,
			ColonyResource.ResourceType.MINERALS: 200
		},
		"hourly_resources_generated": {
			ColonyResource.ResourceType.SCIENCE: 10
		}
	},
}

# Exported variables
export(BuildingType) var building_type
export(int) var build_cost = 0
export(Vector2) var grid_position = Vector2(-1,-1)

# Nodes
onready var sprite = $Sprite

func _ready():
	update_texture()

#func update_texture():
#	sprite.texture = TEXTURES[building_type]
# Inside Building.gd
# Inside Building.gd
func update_texture():
	#if building_type >= 0 and building_type < BuildingType.MAX_BUILDING_TYPE:
	$Sprite.texture = BuildingMeta[building_type]["texture"]

func get_texture_offset(grid_size):
	var size = $Sprite.texture.get_size()
	var difference = size - grid_size
	return Vector2(difference.x / 2 + 3, difference.y / 2 * -1 + 3)

func get_build_cost():
	return build_cost

func generate_resources(hours):
	var resources = {}
	for resource_type in BuildingMeta[building_type]["hourly_resources_generated"]:
		resources[resource_type] = BuildingMeta[building_type]["hourly_resources_generated"][resource_type] * hours
	return resources