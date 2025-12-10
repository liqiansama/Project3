extends Node2D

var speed = 0
var on_ground = false
@export var animated_sprite : AnimatedSprite2D

func _process(delta: float) -> void:
	if Game.can_control == true:
		if speed > .2 and on_ground:
			animated_sprite.play("run")
		elif speed > .2 and !on_ground:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("magic")
