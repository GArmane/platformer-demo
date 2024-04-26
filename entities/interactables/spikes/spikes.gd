class_name TrapSpikes extends Node2D

signal hit(spike: TrapSpikes, target: Node2D)


func _on_body_entered(body: Player) -> void:
	body.damage()
