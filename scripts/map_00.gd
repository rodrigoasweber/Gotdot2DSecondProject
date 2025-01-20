extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.game_first_load:
		$player.position.x = global.player_start_map00_pos_x
		$player.position.y = global.player_start_map00_pos_y
	else:
		$player.position.x = global.player_exit_map01_pos_x
		$player.position.y = global.player_exit_map01_pos_y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()

func _on_map_01_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true

func _on_map_01_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = false

func change_scene() -> void:
	if global.transition_scene:
		if global.current_scene == "map_00":
			get_tree().change_scene_to_file("res://scenes/map_01.tscn")
			global.game_first_load = false
			global.finish_scene_transaction_to("map_01")
