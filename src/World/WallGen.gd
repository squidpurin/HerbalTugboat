extends Position2D

export(PackedScene) var wall

export(int) var grid_size

#initialisation
var current_block_number = 0;
signal instance_node(node, location)

func _process(delta: float) -> void:
	if Global.level != null:
		if !is_connected("instance_node", Global.level, "instance_node"):
			connect("instance_node", Global.level, "instance_node")
	
	if current_block_number < Global.get("player").position.y / grid_size:	
		# Position
		global_position.y += grid_size
		
		# Generation
		emit_signal("instance_node", wall, Vector2(grid_size*0, global_position.y))
		emit_signal("instance_node", wall, Vector2(grid_size*14, global_position.y))
		current_block_number += 1
