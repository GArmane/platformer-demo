class_name TrapSpikes extends Node2D

signal hit(spike: TrapSpikes, target: Node2D)


func _on_body_entered(body: Node2D) -> void:
	var target := body as Player

	if target:
		target.damage()