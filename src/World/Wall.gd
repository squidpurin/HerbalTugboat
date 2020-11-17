extends StaticBody2D

export(int) var grid_size = 48

func _process(delta: float) -> void:
	if position.y < Global.get("player").position.y - get_viewport().size.y * 2 / 0.3:
		queue_free()
