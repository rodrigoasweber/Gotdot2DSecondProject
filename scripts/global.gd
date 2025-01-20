extends Node

var player_current_atk:bool = false

var transition_scene:bool = false

var player_exit_map01_pos_x:float = 551
var player_exit_map01_pos_y:float = 24
var player_start_map00_pos_x:float = 35
var player_start_map00_pos_y:float = 158

var game_first_load:bool = true

func finish_scene_transaction() -> void:
	if transition_scene:
		transition_scene = false
