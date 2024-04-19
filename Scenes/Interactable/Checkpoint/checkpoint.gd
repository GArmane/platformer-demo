class_name Checkpoint extends Node2D


@onready var status := false
@onready var animation_player: AnimationPlayer = $AnimationPlayer


signal activated(checkpoint: Checkpoint)
signal deactivated(checkpoint: Checkpoint)


# Public API
func activate() -> bool:
	status = true
	animation_player.play("Activated")
	emit_signal("activated", self)
	
	return status


func deactivate() -> bool:
	status = false
	animation_player.stop()
	emit_signal("deactivated", self)
	
	return status


# Signal callbacks
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !status:
		activate()
