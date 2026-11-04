extends CharacterBody2D


var SPEED = 300
var JUMP_VELOCITY = -400.0
var dash = false
var dashspeed = 600
var speedcheck = 300
var maxjump = 3
var jump = 0

@onready var animatedsprite: AnimatedSprite2D = $"Player Animation"

func _physics_process(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor():
		jump = 0
	
	if Input.is_action_just_pressed("ui_accept") and maxjump > jump:
		velocity.y = JUMP_VELOCITY
		jump += 1
	
	if Input.is_action_just_pressed("dash"):
		dashactivate()
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction > 0:
		animatedsprite.flip_h = false
	elif direction < 0:
		animatedsprite.flip_h = true
	
	if direction == 0:
		animatedsprite.play("Idle")
	else:
		animatedsprite.play("Walk")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func dashactivate():
	if dash == false:
		dash = true
		speedcheck = SPEED
		SPEED = dashspeed
		await get_tree().create_timer(0.5).timeout
		SPEED = speedcheck
		dash = false
