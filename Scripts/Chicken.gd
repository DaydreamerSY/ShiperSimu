extends CharacterBody2D

@export var food: Node2D = null
@onready var navigation_agen_2d = $NavigationAgent2D
@onready var skin = $Skin

signal is_finish_moving

var food_list

var movement_speed = 50
var is_start_moving = false


func _ready():
	call_deferred("chicken_setup")
	food_list = get_tree().get_nodes_in_group("food")[0]
	print(navigation_agen_2d.get_pathfinding_algorithm())
	pass


func chicken_setup():
	await get_tree().physics_frame

	if food:
		print(food.position)
		print(food.global_position)

		navigation_agen_2d.set_target_position(food.global_position)

		print(navigation_agen_2d.target_position)

		print(navigation_agen_2d.get_final_position())
		print(navigation_agen_2d.get_current_navigation_path())

	pass
	
func let_go():
	is_start_moving = true


func update_food_list():
	var available_food = food_list.get_children()

	if !available_food.is_empty():
		var next_food = available_food[0]
		food = next_food
	else:
		is_start_moving = false
		is_finish_moving.emit()


func _physics_process(_delta):
	
	if !is_start_moving:
		return

	if is_instance_valid(food):
		navigation_agen_2d.target_position = food.global_position
	else:
		update_food_list()


	if navigation_agen_2d.is_navigation_finished():
		return

	var current_agent_position = global_position
	var next_path_position = navigation_agen_2d.get_next_path_position()

	var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed

	if navigation_agen_2d.avoidance_enabled:
		navigation_agen_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)


	move_and_slide()
	skin.flip_h = false if velocity.x > 0 else true
	# print("Move from %s to %s" % [current_agent_position, next_path_position])
	pass

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	pass
