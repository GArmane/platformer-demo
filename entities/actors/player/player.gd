class_name Player extends CharacterBody2D

@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _hitbox: Area2D = $Hitbox
@onready var _sprite2d: Sprite2D = $Sprite2D
@onready var coins := 0

@export var attacking := false
@export var speed := 300.0
@export var jump_velocity := -400.0

signal death(player: Player)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: Variant = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := Vector2.ZERO


# Public API
func damage() -> bool:
	emit_signal("death", self)
	return true


func give_coin(coin: Coin) -> int:
	coins += coin.value
	return coins


# Private API
func _attack() -> void:
	_animation_player.play("with_sword/attack_1")


func _update_animation() -> void:
	if !attacking:
		if velocity.x:
			_animation_player.play("with_sword/run")
			_sprite2d.flip_h = bool(direction.x == -1)
		else:
			_animation_player.play("with_sword/idle")

		if velocity.y < 0:
			_animation_player.play("with_sword/jump")
		elif velocity.y > 0:
			_animation_player.play("with_sword/fall")


func _update_hitbox() -> void:
	_hitbox.position.x = abs(_hitbox.position.x) \
		* (-1 if _sprite2d.flip_h else 1)
	_hitbox.monitoring = attacking


func _update_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Handle movement direction
	if direction:
		velocity.x = direction.x * speed
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

	direction.x = Input.get_axis("left", "right") as int
	_update_movement(delta)
	_update_hitbox()
	_update_animation()


func _on_hitbox_body_entered(body: Fiercetooth) -> void:
	body.damage()
