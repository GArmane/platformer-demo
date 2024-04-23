class_name BaseGameController extends Node


@export var game_ui: GameUI
@export var player: Player
@export var spawn_point: Checkpoint


# Private API
func _respawn_player() -> void:
	player.position = spawn_point.global_position


# Engine callbacks
func _ready() -> void:
	spawn_point.activate()
	_respawn_player()


# Signals
func _on_checkpoint_activated(
	checkpoint: Checkpoint,
	activator: Node2D
) -> void:
	if activator is Player && checkpoint != spawn_point:
		checkpoint.activate()
		spawn_point.deactivate()
		spawn_point = checkpoint


func _on_coin_collected(coin: Coin, collector: Node2D) -> void:
	if collector is Player:
		var total_coins := player.give_coin(coin)
		game_ui.update_coin_display(total_coins)
		coin.destroy()


func _on_player_death(_player: Player) -> void:
	_respawn_player()
