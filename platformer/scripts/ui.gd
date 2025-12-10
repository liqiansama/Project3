extends CanvasLayer

func _ready() -> void:
	Game.coin_collected.connect(coin_collected)
	$txtCoins.text = str(Game.coins_collected)
	$txtTime.text = "00:00"

func coin_collected():
	$txtCoins.text = str(Game.coins_collected)

func _process(delta: float) -> void:
	var elapsed = Game.elapsed_time
	var minutes = int(elapsed) / 60
	var seconds = int(elapsed) % 60
	$txtTime.text = "%02d:%02d" % [minutes, seconds]
