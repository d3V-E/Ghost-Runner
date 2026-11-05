extends CharacterBody2D


@onready var ghost = $"Ghost Collision"

var SPEED = 300.0



func _physics_process(_delta):
	var player = %Player
	var direction = (player.global_position - global_position).normalized()
	#if player.global_position.x < ghost.global_position.x:
		#var reverse = (player.global_position.x - 200)
		#global_position.x = reverse
	velocity = direction * SPEED
	move_and_slide()
