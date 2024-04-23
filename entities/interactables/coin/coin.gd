class_name Coin extends Node2D


@onready var _animation_player: AnimationPlayer = $AnimationPlayer

@export var value := 1

signal collected(coin: Coin, collector: Node2D)


# Public API
func destroy() -> void:
	queue_free()


# Engine callbacks
func _ready() -> void:
	# Set idle animation to random start point.
	var anim_name := "Idle"
	_animation_player.play(anim_name)
	_animation_player \
		.seek(randf_range(0.0, _animation_player \
			.get_animation(anim_name).length)
		)


# Signal handlers
func _on_body_entered(body: Node2D) -> void:
	emit_signal("collected", self, body)
