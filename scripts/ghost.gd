extends CharacterBody2D


@onready var ghost = $"Ghost Collision"

var SPEED = 300.0



func _physics_process(_delta):
	var player = %Player

	#var distance = global_position.distance_to(player.global_position)
	#if player:
	#if not player or not is_instance_valid(player):
	#	return
	var direction = (player.global_position - global_position).normalized()
	#if distance <= 50 :
	#if ghost.global_position.x > player.global_position.x:
		#ghost.global_position.x -= (ghost.global_position.x - player.global_position.x - 100)
	velocity = direction * SPEED
	#else:
		#if player.global_position.x > global_position.x:
			#velocity.x = SPEED
		#else:
			#velocity.x = -SPEED
		#if player.global_position.x < ghost.global_position.x:
			#var reverse = (player.global_position.x - 200)
			#global_position.x = reverse
	move_and_slide()
