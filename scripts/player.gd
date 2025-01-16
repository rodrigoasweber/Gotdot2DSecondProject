extends CharacterBody2D


const SPEED = 100
var current_direction:String = "none"

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta: float) -> void:
	
	if Input.is_action_pressed("move_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		current_direction = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("move_up"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
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
