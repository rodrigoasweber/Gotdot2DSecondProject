extends CharacterBody2D

var health: int = 100
var player_in_atk_zone:bool = false
var can_take_dmg:bool = true

const SPEED:int = 40
var in_chase:bool = false
var player:CharacterBody2D = null

func _physics_process(delta: float) -> void:
	deal_with_dmg()
	
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

func enemy() -> void:
	pass

func _on_slime_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_atk_zone = true

func _on_slime_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_atk_zone = false

func deal_with_dmg() -> void:
	if player_in_atk_zone and global.player_current_atk and can_take_dmg:
		health = health - 20
		can_take_dmg = false
		$take_dmg_cd.start()
		print("slime health: ", health) 
		if health <= 0:
			self.queue_free()

func _on_take_dmg_cd_timeout() -> void:
	can_take_dmg = true
