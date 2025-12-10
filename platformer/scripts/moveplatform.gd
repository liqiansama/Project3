extends Node2D

@export var move_distance: int
@export var speed: float = 100.0

var direction := 1
var start_x: float

func _ready() -> void:
	start_x = position.x

func _process(delta: float) -> void:
	position.x += direction * speed * delta
	
	if position.x > start_x + move_distance:
		position.x = start_x + move_distance
		direction = -1
	elif position.x < start_x - move_distance:
		position.x = start_x - move_distance
		direction = 1
