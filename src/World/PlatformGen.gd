extends Position2D

export(PackedScene) var platform
export(PackedScene) var enemy
export(PackedScene) var birb


export(int) var grid_size = 16
export(int) var dist_min = 6
export(int) var dist_max = 12
export(int) var x_min = 1
export(int) var x_max = 14
export(int) var width_min = 1
export(int) var width_max = 3
export(float) var enemy_thresh = 0.2
export(float) var birb_thresh = 0.2
export(float) var thicc_thresh = 0.2

var gen_height = 0;
var rng = RandomNumberGenerator.new()
var enemy_counter = 0;
var last_xpos = 0;
signal instance_node(node, location)

func _ready() -> void:
	rng.randomize()

func _process(delta: float) -> void:
	if Global.level != null:
		if !is_connected("instance_node", Global.level, "instance_node"):
			connect("instance_node", Global.level, "instance_node")
	
	if gen_height < (Global.get("player").position.y + get_viewport().size.y) / grid_size :	
		# Randomisation
		var distance = rng.randi_range(dist_min, dist_max)
		var xpos = rng.randi_range(x_min, x_max)
		while xpos == last_xpos:
			xpos = rng.randi_range(x_min, x_max)
		var width_left = rng.randi_range(width_min, width_max)
		var width_right = rng.randi_range(width_min, width_max)
		var enemy_chance = rng.randf_range(0, 1)
		var birb_chance = rng.randf_range(0, 1)
		var thicc_chance = rng.randf_range(0, 1)
		
		# Position
		global_position.y += grid_size * distance
		global_position.x = grid_size * xpos
		
		# Generation
		for i in range(max(xpos - width_left, x_min), min(xpos + width_right, x_max)):
			var pos = grid_size * i
			emit_signal("instance_node", platform, Vector2(pos, global_position.y))
		gen_height += distance
		
		# If thicc
		if thicc_chance < thicc_thresh:
			width_left = rng.randi_range(width_min, width_max)
			width_right = rng.randi_range(width_min, width_max)
			for i in range(max(xpos - width_left, x_min), min(xpos + width_right, x_max)):
				var pos = grid_size * i
				emit_signal("instance_node", platform, Vector2(pos, global_position.y + grid_size))
		
		# Enemy Spawn
		if enemy_chance < enemy_thresh:
			emit_signal("instance_node", enemy, Vector2(xpos * grid_size, global_position.y - grid_size))
			pass
			
		if birb_chance < birb_thresh:
			emit_signal("instance_node", birb, Vector2(xpos * grid_size, global_position.y - grid_size))
			pass
