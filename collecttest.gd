extends CharacterBody2D

@export var target: Node2D


func _process(delta):
	if target:
		global_position = global_position.lerp(target.global_position, 0.2)
		
