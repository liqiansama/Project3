extends Node2D

var amplitude := 4
var speed := 0.8  

func _ready():
	_start_floating()


func _start_floating():
	var tween = create_tween()
	tween.set_loops()  

	var up_pos = position + Vector2(0, -amplitude)
	var down_pos = position + Vector2(0, amplitude)

	tween.tween_property(self, "position", up_pos, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", down_pos, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
