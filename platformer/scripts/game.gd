extends Node

var keys = 0
var coins_collected = 0
signal coin_collected
var change = false
var change_sig = true
var can_control = true
var label_num = 0

var elapsed_time: float = 0.0
var timing_active: bool = false 

func _process(delta: float) -> void:
	if timing_active:
		elapsed_time += delta

func start_timer():
	elapsed_time = 0.0   
	timing_active = true  

func stop_timer():
	timing_active = false 
	
func collect_coin():
	coins_collected += 1
	coin_collected.emit()
	
func collect_key():
	keys += 1
	
func use_key():
	if keys > 0:
		keys -= 1

func _change_ver():
	change = true

func changeend():
	change = false
	
func change_signal():
	change_sig = !change_sig
	print(change_sig)
	
func rechange():
	change_sig = true
	
func _can_control():
	can_control = !can_control

func labelnumber1():
	label_num = 1

func labelnumber2():
	label_num = 2
