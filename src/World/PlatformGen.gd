extends Position2D

export(PackedScene) var platform
export(int) var grid_size
export(int) var max_blocks
export(int) var dist_min = 4
export(int) var dist_max = 12
export(int) var x_min = 1
export(int) var x_max = 13
export(int) var width_min = 1
export(int) var width_max = 3

#initialisation
var current_block_number = 0;
var rng = RandomNumberGenerator.new()
signal instance_node(node, location)

func _ready() -> void:
	rng.randomize()

func _process(delta: float) -> void:
	if Global.level != null:
		if !is_connected("instance_node", Global.level, "instance_node"):
			connect("instance_node", Global.level, "instance_node")
	
	if current_block_number < max_blocks:
		# Randomisation
		var distance = rng.randi_range(dist_min, dist_max)
		var xpos = rng.randi_range(x_min, x_max)
		var width_left = rng.randi_range(width_min, width_max)
		var width_right = rng.randi_range(width_min, width_max)
		
		# Position
		global_position.y += grid_size * distance
		global_position.x = grid_size * xpos
		
		# Generation
		# Left
		for i in range(xpos - width_left, xpos + width_right):
			var pos = grid_size * i
			emit_signal("instance_node", platform, Vector2(pos, global_position.y))
		current_block_number += 1
	else:
		queue_free()
