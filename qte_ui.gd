extends CanvasLayer

var arrow_icons = {
	"up": preload("res://platformer/icon.svg"),
	"down": preload("res://platformer/icon.svg"),
	"left": preload("res://platformer/icon.svg"),
	"right": preload("res://platformer/icon.svg"),
}

var arrows = []
var sequence = []
var current_index = 0

func show_qte(seq: Array):
	sequence = seq
	current_index = 0
	arrows.clear()

	$QTEPanel.visible = true
	$TimeBar.visible = true

	# 清空旧箭头
	for c in $QTEPanel.get_children():
		if c.name != "TemplateArrow":
			c.queue_free()

	# 生成新箭头
	for dir in sequence:
		var a = $QTEPanel.get_node("TemplateArrow").duplicate()
		a.texture = arrow_icons[dir]
		a.visible = true
		a.modulate = Color(1,1,1,0.4)
		$QTEPanel.add_child(a)
		arrows.append(a)

	highlight_current()

func highlight_current():
	for i in range(sequence.size()):
		if i < current_index:
			arrows[i].modulate = Color(0.2, 1.0, 0.2)
		elif i == current_index:
			arrows[i].modulate = Color(1, 1, 1, 1)
		else:
			arrows[i].modulate = Color(1, 1, 1, 0.4)

func mark_fail():
	if current_index < arrows.size():
		arrows[current_index].modulate = Color(1, 0.3, 0.3)

func update_timebar(percent: float):
	$TimeBar.value = percent * 100

func hide_qte():
	$QTEPanel.visible = false
	$TimeBar.visible = false
