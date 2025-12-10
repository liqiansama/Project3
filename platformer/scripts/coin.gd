extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Game.collect_coin()
	$AudioStreamPlayer.play()
	$CollisionShape2D.call_deferred("queue_free")
	$AnimatedSprite2D.call_deferred("queue_free")
	pass # Replace with function body.
