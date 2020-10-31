extends Area2D


onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var score: = 1


func body_entered(body: Node) -> void:
	picked()


func picked() -> void:
	PlayerData.score += score
	anim_player.play("fadeout")
