extends Area2D

var is_mouse_entered = false

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	queue_free()
	pass

func update_order(order_id):
	$order.text = str(order_id + 1)
