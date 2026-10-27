extends CharacterBody2D


const SPEED = 200.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Видит ли враг игрока
var is_player_detected = false
#Сылка на самого игрока, чтобы знать, куда он бежит
var player_node = null

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_player_detected and player_node:
		var direction_x = sign(player_node.global_position.x - global_position.x)
		
		velocity.x = direction_x * SPEED
		
		if direction_x != 0:
			$Sprite2D.flip_h = direction_x < 0
	
	else:
		velocity.x = 0

	move_and_slide()


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		is_player_detected = true
		player_node = body


func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		is_player_detected = false
		player_node = null
