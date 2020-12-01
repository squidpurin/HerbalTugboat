extends StaticBody2D

export(int) var grid_size = 16

var view_x = null
var view_y = null

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	view_x = get_viewport().size.x
	view_y = get_viewport().size.y
	if position.y < Global.get("player").position.y - (view_y / view_x) * 240:
#		print("PLAT | Player Y:" + str(Global.get("player").position.y))
#		print("       Viewport X:" + str(view_x))
#		print("       Viewport Y:" + str(view_y))
		queue_free()
