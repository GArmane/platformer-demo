class_name CoinsDisplay extends Control

@onready var icon: TextureRect = $Icon
@onready var qtd: Label = $Qtd
@onready var qtd_text := "x %d"


# Public API
func update_qtd(new_qtd: int) -> int:
	qtd.text = qtd_text % [new_qtd]
	return new_qtd


# Engine callbacks
func _ready() -> void:
	qtd.text = qtd_text % [0]
