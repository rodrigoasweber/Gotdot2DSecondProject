extends CharacterBody2D

const SPEED = 40
var in_chase = false
var player = null

func _physics_process(delta: float) -> void:
	
	if in_chase:
		position += (player.position - position)/SPEED
		play_animation(1)
	else:
		play_animation(0)
		
	move_and_slide()
	

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	in_chase = true
	
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	in_chase = false

func play_animation(movement: int) -> void:
	var animation = $AnimatedSprite2D
	
	if 	movement == 1:
		animation.play("front_walk")
	elif movement == 0:
		animation.play("front_idle")
	
