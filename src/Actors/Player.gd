extends Actor

export var stomp_impulse: = 1000.0
export var health = 1000

var direction: = get_direction()
var invincible = false

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	
func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:	
	if invincible == false:
		health -= 1
		modulate.a = 0.5
		invincible = true
		$Timer.start()
	if health < 0:
		queue_free()	
		
func _on_Timer_timeout() -> void:
	modulate.a = 1.0
	invincible = false
	
		
func _process(delta: float) -> void:
	Global.set("player", self)
	$Label.text = str(health)

func _physics_process(delta: float) -> void:
	direction = get_direction()
	set_sprite()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if is_on_floor() else 1.0
	)
	
func set_sprite() -> void:
	if direction.x == Vector2.LEFT.x:
		$player.set_flip_h( true )
	elif direction.x == Vector2.RIGHT.x:
		$player.set_flip_h( false )

func calculate_move_velocity(
		linear_velocity: Vector2, 
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var out:= linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if out.y > 0.0:
		out.x *= 0.8
		out.y += 0.04 * abs(out.x / 1000) * gravity
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
