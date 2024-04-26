class_name CameraComponent extends Camera2D

@export var target: Node2D

# Engine callbacks
func _process(_delta: float) -> void:
	set_position(target.get_position())
