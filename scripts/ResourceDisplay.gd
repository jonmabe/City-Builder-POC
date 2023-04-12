extends Control

const ColonyResource = preload("res://scripts/ColonyResource.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_resource_labels(resources):
	get_node("VBoxContainer/Food").text = "Food: " + str(resources[ColonyResource.ResourceType.FOOD])
	get_node("VBoxContainer/Water").text = "Water: " + str(resources[ColonyResource.ResourceType.WATER])
	get_node("VBoxContainer/Energy").text = "Energy: " + str(resources[ColonyResource.ResourceType.ENERGY])
	get_node("VBoxContainer/Minerals").text = "Minerals: " + str(resources[ColonyResource.ResourceType.MINERALS])
	get_node("VBoxContainer/Population").text = "Population: " + str(resources[ColonyResource.ResourceType.POPULATION])
	get_node("VBoxContainer/Science").text = "Science: " + str(resources[ColonyResource.ResourceType.SCIENCE])
