extends "res://src/Actors/Actor.gd"


func _ready() -> void:
	_velocity.x = -speed.x
	
	
func _on_StompDetection_body_entered(body: Node) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	# This line under is not needed.
	get_node("CollisionShape2D")
	queue_free()

	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	var snap: = Vector2.DOWN * 50
	# The .y is needed without it its fucked up.
	_velocity.y = move_and_slide_with_snap(
	_velocity, snap, FLOOR_NORMAL, true, 4, PI / 3).y
	
