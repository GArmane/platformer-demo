class_name BaseGameController extends Node


@export var player: Player
@export var current_checkpoint: Checkpoint


# Private API
func _respawn_player() -> void:
	player.position = current_checkpoint.global_position


func _set_checkpoint(new_checkpoint: Checkpoint) -> Checkpoint:
	var old_checkpoint := current_checkpoint
	if old_checkpoint != new_checkpoint:
		old_checkpoint.deactivate()
		current_checkpoint = new_checkpoint
	
	return old_checkpoint


# Signal handlers
func _on_checkpoint_activated(checkpoint: Checkpoint) -> void:
	_set_checkpoint(checkpoint)


func _on_player_death(_player: Player) -> void:
	_respawn_player()


func _on_player_received_coin(_player: Player, coin: Coin, total: int) -> void:
	print("Coin value: %s, Total coins: %s" % [coin.value, total])
