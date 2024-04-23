class_name GameUI extends CanvasLayer


@onready var coins_display: CoinsDisplay = %CoinsDisplay


func update_coin_display(qtd: int) -> int:
	return coins_display.update_qtd(qtd)
