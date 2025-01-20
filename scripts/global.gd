extends Node

var player_current_atk:bool = false

var current_scene:String = "map_00"
var transition_scene:bool = false

var player_exit_map01_pos_x:float = 551
var player_exit_map01_pos_y:float = 24
var player_start_map00_pos_x:float = 35
var player_start_map00_pos_y:float = 158

var game_first_load:bool = true

func finish_scene_transaction_to(new_scene: String) -> void:
	if transition_scene:
		transition_scene = false
		current_scene = new_scene
	print("new_scene: ", new_scene)
	print("current_scene: ", current_scene)
