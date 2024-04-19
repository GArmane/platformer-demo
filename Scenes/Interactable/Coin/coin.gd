class_name Coin extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var value := 1


# Engine callbacks
func _ready() -> void:
	# Set idle animation to random start point.
	var anim_name := "Idle"
	animation_player.play(anim_name)
	animation_player \
		.seek(randf_range(0.0, animation_player \
			.get_animation(anim_name).length)
		)


# Signal handlers
func _on_area_2d_area_entered(area: Area2D) -> void:
	var target := area.get_parent() as Player
	if target:
		target.give_coin(self)
		queue_free()
