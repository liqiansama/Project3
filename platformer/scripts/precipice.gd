extends Area2D
@onready var teleport_target: Marker2D = get_tree().current_scene.get_node("precipices")
var check_num = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if check_num == 1:
		teleport_target = get_tree().current_scene.get_node("precipices1")
		
func _check_mum_plus() -> void:
	check_num += 1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.global_position = teleport_target.global_position
		$"../fall".play()
