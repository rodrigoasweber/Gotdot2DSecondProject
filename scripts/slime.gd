extends CharacterBody2D

const SPEED = 40
var in_chase = false
var player = null

func _physics_process(delta: float) -> void:
	var animation = $AnimatedSprite2D
	
	if in_chase:
		position += (player.position - position)/SPEED
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
			animation.play("side_walk")
		else:
			$AnimatedSprite2D.flip_h = false
			animation.play("side_walk")
	else:
		animation.play("front_idle")
		
	move_and_slide()
	

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	in_chase = true
	
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	in_chase = false
