extends Actor

export var stomp_impulse: = 1500.0


func _on_StompDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	die()


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	var snap: = Vector2.DOWN * 65 if direction.y == 0.0 else Vector2.ZERO
	# The .y is not needed in order to work. But in the enemy yes.
	_velocity.y = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true, 4, PI / 3.0
	).y


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		- 1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)


func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out


func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
	
	
func die() -> void:
	PlayerData.deaths += 1
	queue_free() 




