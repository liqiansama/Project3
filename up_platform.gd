extends Node2D

@export var raise_distance: float = 70
@export var raise_speed: float = 80.0  

var player_in_area: bool = false
var is_raising: bool = false
var start_position: Vector2
var target_position: Vector2

@onready var platform = $Platform
@onready var area = $Area2D
@onready var label = $Label

func _ready():
	label.visible = false
	start_position = platform.position
	target_position = start_position - Vector2(0, raise_distance)

func _process(delta):
	if player_in_area and not is_raising:
		if Input.is_action_just_pressed("act") && Game.change_sig == false:
			is_raising = true
			label.visible = false
			$sound.play()
			await get_tree().create_timer(0.5).timeout
			$up_platform.play()
			
	if is_raising:
		platform.position = platform.position.move_toward(target_position, raise_speed * delta)

		if platform.position.distance_to(target_position) < 1:
			platform.position = target_position
			is_raising = false 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && Game.change_sig == false:
		player_in_area = true
		label.visible = true
		label.text = "E"  
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
		label.visible = false
