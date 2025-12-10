extends CanvasLayer
@onready var label = $Label
@onready var label2 = $Label2
@onready var label3 = $Label3
@onready var label4 = $Label4

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.label_num == 1:
		label.visible = false
		label2.visible = true
		label3.visible = false
		label4.visible = false
	elif Game.label_num == 2:
		label.visible = false
		label2.visible = false
		label3.visible = true
		label4.visible = true
