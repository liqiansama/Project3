extends Area2D

@onready var point1 = $Marker2D
@onready var point2 = $Marker2D2
@onready var point3 = $Marker2D3
@onready var hint_label = $CanvasLayer/HintLabel
@onready var book = $book
@onready var cam = get_tree().get_root().get_node("Plevel2/PlatformerPlayer/Camera2D")
@onready var player = get_tree().get_root().get_node("Plevel2/PlatformerPlayer/AnimatedSprite2D")
@onready var knight = get_tree().get_root().get_node("Plevel2/knight/AnimatedSprite2D")

var items_in_area: Array = []
var max_items := 3

var player_in_area := false

func _ready():
	hint_label.visible = false
	add_to_group("place_area")

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		_update_hint()

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
		_hide_hint()

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("act"):
		_try_place_item()

func _try_place_item():
	if items_in_area.size() >= max_items:
		Game._change_ver()
		Game._can_control()
		$fires.visible = true
		$magic_voice.play()
		book.play("default")
		await get_tree().create_timer(3.0).timeout
		cam.position.y += 1000
		await get_tree().create_timer(4.0).timeout
		cam.position.y -= 1000
		Game._can_control()
		Game.labelnumber2()
		
		
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	
	var item = player.current_item
	if not item:
		return
	
	var idx = items_in_area.size()
	var target_position: Vector2
	match idx:
		0: target_position = point1.global_position
		1: target_position = point2.global_position
		2: target_position = point3.global_position
	
	item.global_position = target_position
	$put.play()
	
	item.target = null
	
	var col = item.get_node_or_null("CollisionShape2D")
	if col:
		col.disabled = true
	
	items_in_area.append(item)
	player.current_item = null
	
	_update_hint()

func _update_hint():
	if not player_in_area:
		_hide_hint()
		return
	
	var player = get_tree().get_first_node_in_group("player")
	if items_in_area.size() < max_items and player and player.current_item:
		hint_label.text = "Press E to place (%d/%d)" % [items_in_area.size(), max_items]
		hint_label.visible = true
	elif items_in_area.size() >= max_items:
		Game.labelnumber1()
		hint_label.text = "Press E to start ritual"
		hint_label.visible = true
		
	else:
		_hide_hint()


func _hide_hint():
	hint_label.visible = false
