extends StaticBody2D

export(int) var grid_size = 48

func _process(delta: float) -> void:
	if position.y < Global.get("player").position.y - get_viewport().size.y:
		queue_free()

