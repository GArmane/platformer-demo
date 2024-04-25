class_name Player extends CharacterBody2D

@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _attacks_collision: Area2D = $AttacksCollision
@onready var _sprite2d: Sprite2D = $Sprite2D
@onready var coins := 0

@export var attacking := false
@export var speed := 300.0
@export var jump_velocity := -400.0

signal death(player: Player)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: Variant = ProjectSettings.get_setting("physics/2d/default_gravity")


# Public API
func damage() -> bool:
	emit_signal("death", self)
	return true


func give_coin(coin: Coin) -> int:
	coins += coin.value
	return coins


# Private API
func _attack() -> void:
	for area in _attacks_collision.get_overlapping_areas():
		print(area.get_parent().name)
		
	_animation_player.play("with_sword/attack_1")


func _update_animation(direction: int) -> void:
	if !attacking:
		if velocity.x:
			_animation_player.play("with_sword/run")
			_sprite2d.flip_h = bool(direction == -1)
		else:
			_animation_player.play("with_sword/idle")

		if velocity.y < 0:
			_animation_player.play("with_sword/jump")
		elif velocity.y > 0:
			_animation_player.play("with_sword/fall")


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
		_attacks_collision.scale.x = abs(_attacks_collision.scale.x) * direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


# Engine callbacks
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		_attack()


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right") as int

	_update_movement(delta, direction)
	_update_animation(direction)
