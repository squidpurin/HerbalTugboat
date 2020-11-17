extends Position2D

export(PackedScene) var wall

export(int) var grid_size

#initialisation
var gen_height = 0;
signal instance_node(node, location)

func _process(delta: float) -> void:
	if Global.level != null:
		if !is_connected("instance_node", Global.level, "instance_node"):
			connect("instance_node", Global.level, "instance_node")
	
	if gen_height < (Global.get("player").position.y * 0.3 + get_viewport().size.y) / grid_size:
		# Position
		global_position.y += grid_size
		
		# Generation
		emit_signal("instance_node", wall, Vector2(grid_size*0, global_position.y))
		emit_signal("instance_node", wall, Vector2(grid_size*14, global_position.y))
		gen_height += 1
