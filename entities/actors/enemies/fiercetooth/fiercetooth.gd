class_name Fiercetooth extends CharacterBody2D


@onready var _anim_player: AnimationPlayer = $AnimationPlayer
@onready var _ground_detector: RayCast2D = $GroundDetector
@onready var _hitbox: Area2D = $Hitbox

@export var speed := 60.0
@export var jump_velocity := -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var _dead := false
var _direction := -1


# Public API
func damage() -> bool:
	speed = 0
	_dead = true
	_hitbox.monitoring = false
	_anim_player.play("default/dead_hit")
	return true


# Private API
func _update_animation() -> void:
	if _direction:
		_anim_player.play("default/run")
	else:
		_anim_player.play("default/idle")


func _update_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta

	if !_ground_detector.is_colliding() && is_on_floor():
		_direction *= -1
		scale.x = abs(scale.x) * -1

	velocity.x = speed * _direction
	move_and_slide()

# Engine callbacks
func _ready() -> void:
	_anim_player.play("default/idle")


func _physics_process(delta: float) -> void:
	if !_dead:
		_update_movement(delta)
		_update_animation()


# Signal handlers
func _on_hitbox_body_entered(body: Player) -> void:
	body.damage()
