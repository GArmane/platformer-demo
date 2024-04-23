class_name Checkpoint extends Node2D


@onready var status := false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal activated(checkpoint: Checkpoint, activator: Node2D)


# Public API
func activate() -> bool:
	status = true
	animation_player.play("Activated")
	
	return status


func deactivate() -> bool:
	status = false
	animation_player.stop()
	
	return status


# Signal callbacks
func _on_body_entered(body: Node2D) -> void:
	if status == false:
		emit_signal("activated", self, body)
