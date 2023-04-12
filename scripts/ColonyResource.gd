class_name ColonyResource

enum ResourceType { FOOD, WATER, ENERGY, MINERALS, POPULATION, SCIENCE }

var type
var amount

func _init(_type, _amount):
    type = _type
    amount = _amount
