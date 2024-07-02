extends Node2D

@export var food_scene : PackedScene
@export var chicken: CharacterBody2D

var food_on_map
var map : TileMap

var is_starting_game = false

func _ready():
	food_on_map = get_tree().get_nodes_in_group("food")[0]
	map = $TileMap
	

func _input(event):
		
	if event.is_action_pressed("add_food") and !is_starting_game:
		var _mouse_pos = get_global_mouse_position()
		var _clicked_cell = map.local_to_map(_mouse_pos)
		var _data = map.get_cell_tile_data(0, _clicked_cell)
		if _data:
			if _data.get_custom_data("food_place"):
				
				var exist_food = food_on_map.get_children()
				var _tile_center = map.map_to_local(_clicked_cell)
				
				for food in exist_food:
					if food.position == _tile_center:
						food.queue_free()
						update_order_food_list()
						return
				
				var _food = food_scene.instantiate();
				_food.position = _tile_center
				food_on_map.add_child(_food)
				update_order_food_list()
				
			

func update_order_food_list():
	var exist_food = food_on_map.get_children()
	for order in range(len(exist_food)):
		exist_food[order].update_order(order)
			


func _on_button_pressed():
	is_starting_game = true
	chicken.let_go()
	pass # Replace with function body.


func _on_chicken_is_finish_moving():
	print("chicken done moving")
	is_starting_game = false
	pass # Replace with function body.
