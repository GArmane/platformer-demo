class_name KillLine extends Area2D


func _on_body_entered(body: Player) -> void:
	body.damage()
