extends Actor

var direction = Vector2.LEFT

export var actual_speed = 3000

func _ready() -> void:
	_velocity.x = speed.x * direction.x
	set_physics_process(false)

func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()

func _physics_process(delta: float) -> void:
	# Wall Bounce
#	if is_on_wall():
#		direction.x = -direction.x
#	set_sprite()
	# Gravity
#	_velocity.y += gravity * delta
	
	# Velocity Update (OLD)
#	_velocity.x = speed.x * direction.x
#	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

	# Velocity Update 
	var u = (get_player_pos() - position)
	var v = u.normalized()
	_velocity = v * actual_speed * delta
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	print("vel = " + str(_velocity) + "\tspd = " + str(speed))
	
func set_sprite() -> void:
	if direction.x == Vector2.LEFT.x:
		$birb.set_flip_h( false )
	elif direction.x == Vector2.RIGHT.x:
		$birb.set_flip_h( true )
		
func charge() -> void:
	pass
		
func get_player_pos() -> Vector2:
	return Global.get("player").position
