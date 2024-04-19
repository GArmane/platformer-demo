extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite2d: Sprite2D = $Sprite2D

@export var speed := 300.0
@export var jump_velocity := -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: Variant = ProjectSettings.get_setting("physics/2d/default_gravity")


# Private API
func _update_animation(direction: int) -> void:
	if velocity.x:
		animation_player.play("Run")
		sprite2d.flip_h = bool(direction == -1)
	else:
		animation_player.play("Idle")

	if velocity.y < 0:
		animation_player.play("Jump")
	elif velocity.y > 0:
		animation_player.play("Fall")


func _update_movement(delta: float, direction: int) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Handle movement direction
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


# Engine callbacks
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")

	_update_movement(delta, direction)
	_update_animation(direction)
