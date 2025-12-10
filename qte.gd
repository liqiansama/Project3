extends Node

signal qte_success
signal qte_failed

var sequence = []
var current_index = 0
var time_limit = 0.7
var timer = 0.0
var active = false

func start_qte(new_sequence: Array, time_per_step := 0.7):
	sequence = new_sequence
	time_limit = time_per_step
	current_index = 0
	timer = 0.0
	active = true

	# 更新 UI
	$QTE_UI.show_qte(new_sequence)

func _process(delta):
	if not active:
		return
	timer += delta
	var percent: float = 1.0 - (timer / time_limit)

	$QTE_UI.update_timebar(percent)

	if timer > time_limit:
		fail_qte("timeout")

func _input(event):
	if not active:
		return

	var key_name = _get_pressed_direction()
	if key_name == "":
		return

	var expected = sequence[current_index]

	if key_name == expected:
		current_index += 1
		timer = 0.0

		$QTE_UI.current_index = current_index
		$QTE_UI.highlight_current()

		if current_index >= sequence.size():
			succeed_qte()
	else:
		$QTE_UI.mark_fail()
		fail_qte("wrong")

func _get_pressed_direction() -> String:
	if Input.is_action_just_pressed("ui_up"): return "up"
	if Input.is_action_just_pressed("ui_down"): return "down"
	if Input.is_action_just_pressed("ui_left"): return "left"
	if Input.is_action_just_pressed("ui_right"): return "right"
	
	return ""

func succeed_qte():
	active = false
	$QTE_UI.hide_qte()
	emit_signal("qte_success")

func fail_qte(reason):
	active = false
	$QTE_UI.hide_qte()
	emit_signal("qte_failed")
