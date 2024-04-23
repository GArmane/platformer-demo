class_name TrapSpikes extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	var target := area.get_parent() as Player
	if target:
		target.damage()
