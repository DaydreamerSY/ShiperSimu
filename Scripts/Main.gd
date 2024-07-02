extends Node2D

@export var food_scene : PackedScene

var food_on_map

func _ready():
	food_on_map = get_tree().get_nodes_in_group("food")[0]

func _input(event):
	if event.is_action_pressed("press"):
		var _food = food_scene.instantiate();
		_food.position = get_global_mouse_position()
		food_on_map.add_child(_food)
