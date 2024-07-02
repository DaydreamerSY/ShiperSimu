extends TileMap


func _use_tile_data_runtime_update(layer, coords):
	if coords in get_used_cells_by_id(1):
		return true
	return false

func _tile_data_runtime_update(layer, coords, tile_data):
	tile_data.set_navigation_polygon(0, null)
	#tile_data.set_custom_data("food placable", false)
	#tile_data.set_custom_data(0, false)
	#print(layer)
	#print(coords)
	#print(tile_data.get_custom_data("food placable"))
