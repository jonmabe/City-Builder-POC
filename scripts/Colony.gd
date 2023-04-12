class_name City

const Building = preload("res://scripts/Building.gd")
const ColonyResource = preload("res://scripts/ColonyResource.gd")
var main_node
var resource_display

var resources

func _init(main):
	main_node = main
	resource_display = main_node.get_node("/root/Main/UI/Resources/HBoxContainer/ResourceDisplay")
	resources = {
		ColonyResource.ResourceType.FOOD: 1000,
		ColonyResource.ResourceType.WATER: 1000,
		ColonyResource.ResourceType.ENERGY: 1000,
		ColonyResource.ResourceType.MINERALS: 1000,
		ColonyResource.ResourceType.POPULATION: 10,
		ColonyResource.ResourceType.SCIENCE: 100,
	}

func collect_resources(hours):
	for building in main_node.buildings:
		add_resources(building.generate_resources(hours))
	update_resource_labels()

func update_resource_labels():
	resource_display.update_resource_labels(resources)        

func add_resources(new_resources):
	for resource_type in new_resources:
		resources[resource_type] += new_resources[resource_type]

func remove_resource(resource_type, amount):
	resources[resource_type] -= amount

func has_enough_resources(building_type):
	var costs = Building.BuildingMeta[building_type]["costs"]
	for cost in costs:
		if resources[cost] < costs[cost]:
			return false
	return true
