extends CharacterBody2D

const SPEED = 40
var in_chase = false
var player = null
var current_direction = "none"

func _physics_process(delta: float) -> void:
	
	var original_x = get_position_delta().x
	var original_y = get_position_delta().y
		
	if in_chase:
		position += (player.position - position)/SPEED
	
	#FIXME not working
	if original_y > position.y:
		current_direction = "right"
		play_animation(1)
	elif original_y < position.y:
		current_direction = "left"
		play_animation(1)
	elif original_x > position.x:
		current_direction = "down"
		play_animation(1)
	elif original_x < position.x:
		current_direction = "up"
		play_animation(1)
	else:
		current_direction = "none"
		play_animation(0)
	
	move_and_slide()
	

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	in_chase = true
	
func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	in_chase = false

func play_animation(movement: int) -> void:
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if 	movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")
	elif direction == "left":
		animation.flip_h = true
		if 	movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")
	elif direction == "down":
		animation.flip_h = true
		if 	movement == 1:
			animation.play("front_walk")
		elif movement == 0:
			animation.play("front_idle")
	elif direction == "up":
		animation.flip_h = true
		if 	movement == 1:
			animation.play("back_walk")
		elif movement == 0:
			animation.play("back_idle")
