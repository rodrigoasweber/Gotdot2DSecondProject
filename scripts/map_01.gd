extends Node2D

func _process(delta: float) -> void:
	change_scene()

func _on_map_00_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true

func _on_map_00_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = false
		
func change_scene() -> void:
	if global.transition_scene:
		get_tree().change_scene_to_file("res://scenes/map_00.tscn")
		global.finish_scene_transaction_to("map_00")
