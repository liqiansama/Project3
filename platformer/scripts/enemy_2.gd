extends CharacterBody2D

const SPEED = 100
var state = "idle"
@onready var teleport_target: Marker2D = get_tree().current_scene.get_node("Marker2D")

func _physics_process(delta: float) -> void:
	# Add the gravity.s
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var player_dir = get_tree().get_nodes_in_group("player")[0].position - self.position
	
	if player_dir.length() < 150:
		state = "chase"
	else:
		state = "idle"
	
	if ( state == "chase" ):
		self.velocity.x = player_dir.normalized().x * SPEED
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	
	self.velocity.x *= .8
	
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Game.collect_key()
		$AnimatedSprite2D.play("death")
		$AudioStreamPlayer.play()
		$CollisionShape2D.call_deferred("queue_free")
		$Area2D/CollisionShape2D.call_deferred("queue_free")
		$hurt/CollisionShape2D.call_deferred("queue_free")

func _on_hurt_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$hurt2.play()
		body.global_position = teleport_target.global_position
