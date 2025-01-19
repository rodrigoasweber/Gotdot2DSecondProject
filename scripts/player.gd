extends CharacterBody2D

var enemy_inatk_range: bool = false
var enemy_atk_cooldown: bool = true
var health: int = 160
var is_alive: bool = true
var is_atk_in_progress: bool = false

const SPEED: int = 100
var current_direction:String = "none"

func _physics_process(delta: float) -> void:
	player_movement(delta)
	deal_with_dmg()
	attack()
	
	if health <= 0:
		is_alive = false ##go back to menu or respaw....
		health = 0
		print("player killed!")
		self.queue_free() ##not good but its what we have for the tutorial
	
	
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
			if is_atk_in_progress == false:
				animation.play("side_idle")
	elif direction == "left":
		animation.flip_h = true
		if 	movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			if is_atk_in_progress == false:
				animation.play("side_idle")
	elif direction == "down":
		animation.flip_h = true
		if 	movement == 1:
			animation.play("front_walk")
		elif movement == 0:
			if is_atk_in_progress == false:
				animation.play("front_idle")
	elif direction == "up":
		animation.flip_h = true
		if 	movement == 1:
			animation.play("back_walk")
		elif movement == 0:
			if is_atk_in_progress == false:
				animation.play("back_idle")


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inatk_range = true
		print("enemy_inatk_range: ", enemy_inatk_range)
		

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inatk_range = false
		
func deal_with_dmg():
	if enemy_inatk_range and enemy_atk_cooldown:
		health = health - 20
		print("player health: ", health)
		enemy_atk_cooldown = false
		$atk_cd.start()
		
		
func _on_atk_cd_timeout() -> void:
	enemy_atk_cooldown = true

func attack() -> void:
	var dir = current_direction
	var animation = $AnimatedSprite2D
	
	if Input.is_action_just_pressed("atk"):
		global.player_current_atk = true
		is_atk_in_progress = true
		if dir == "right":
			animation.flip_h = false
			animation.play("side_atk")
		elif dir == "left":
			animation.flip_h = true
			animation.play("side_atk")
		if dir == "down":
			animation.play("front_atk")
		if dir == "up":
			animation.play("back_atk")
			
		$deal_atk_timer.start()

func _on_deal_atk_timer_timeout() -> void:
	$deal_atk_timer.stop()
	global.player_current_atk = false
	is_atk_in_progress = false

func player() -> void:
	pass
