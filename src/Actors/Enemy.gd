extends Actor

var direction = Vector2.LEFT

func _ready() -> void:
	_velocity.x = speed.x * direction.x
	set_physics_process(false)

func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()

func _physics_process(delta: float) -> void:
	# X Calculation
	if is_on_wall():
		direction.x = -direction.x
	if not $RayCastLeft.get_collider():
		direction = Vector2.RIGHT
	if not $RayCastRight.get_collider():
		direction = Vector2.LEFT
		
	# Y Calculation
	_velocity.y += gravity * delta
	
	# Velocity Update	
	_velocity.x = speed.x * direction.x
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

