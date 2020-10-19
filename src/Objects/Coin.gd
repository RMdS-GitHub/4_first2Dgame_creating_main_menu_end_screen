extends Area2D


onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func body_entered(body: Node) -> void:
	anim_player.play("fadeout")
