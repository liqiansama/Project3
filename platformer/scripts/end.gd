extends Node2D
@onready var cam = $PlatformerPlayer/Camera2D
func _ready() -> void:
	Game.changeend()
	$Camera2D.make_current()

func _on_quit_pressed() -> void:
	get_tree().quit()
