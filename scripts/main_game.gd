extends Node2D

@onready var player = $"Player"
@onready var part = $"Visual Ground"
@onready var background = $"Visual Ground/BackgroundSky"
@onready var barrier = $"Visual Ground/Red Barrier"
@onready var ghostuser = $Ghost
@onready var text = $"UI Canvas/Header"

@onready var ghost1 = $Ghost
@onready var ghost2 = $Ghost1
@onready var ghost3 = $Ghost2
@onready var ghost4 = $Ghost3
@onready var ghost5 = $Ghost4


const save_path = "user://userdata.saves"

signal ghosts_changed


var runs = 0
var gameovertrigger = false
var partcount = []
var backgroundcount = []
var partwidth = 640
var partheight = 360
var time = 6000
var ghosts = 1


func save_data():
	var data = {
		"ghosts": ghosts,
		"runs": runs
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
	file.close()



func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path , FileAccess.READ)
		var data = file.get_var()
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			ghosts = data.get("ghosts" , 1)
			runs = data.get("runs" , 0)
		else:
			save_data()


func _ready():
	load_data()
	backgroundcount.append(background)
	partcount.append(part)
	ghostupd()
	text.visible = false
	gameovertrigger = false
	runs += 1
	#ghostduplicate()

func _process(_delta):
	if player.global_position.x > part.global_position.x:
		duplicatepart()
	if player.global_position.y > background.global_position.y:
		duplicatebackground()

func duplicatepart():
	var clone = part.duplicate()
	clone.global_position.x = part.global_position.x + partwidth
	clone.global_position.y = part.global_position.y
	add_child(clone)
	partcount.append(clone)
	part = clone
	if partcount.size() > 3:
		var oldpart = partcount.pop_front()
		oldpart.queue_free()

func duplicatebackground():
	var cloneb = background.duplicate()
	cloneb.global_position.x = background.global_position.x
	cloneb.global_position.y = background.global_position.y - partheight
	cloneb.z_index = -1
	add_child(cloneb)
	backgroundcount.append(cloneb)
	background = cloneb
	#if backgroundcount.size() > 3:
		#var oldb = backgroundcount.pop_front()
		#oldb.queue_free()
#func _on_test_timeout():
	#print(player.global_position.x)
	#print(player.global_position.y)





func _on_timer_timeout():
	if time <= 0:
		time = 0
		$"UI Canvas/Timer Text".text = "00 : 00 : 00"
		win()
	else:
		@warning_ignore("integer_division")
		var minute = int(time / 6000)
		@warning_ignore("integer_division")
		var seconds = int(time / 100)% 60
		var centi = int(time) % 100
		$"UI Canvas/Timer Text".text = "%02d : %02d : %02d" % [minute , seconds , centi]
		time -= 1

#func ghostduplicate():
	#for i in range(ghosts):
	#	var clone = ghostuser.duplicate()
	#	if player:
	#		clone.global_position = Vector2(
	#			player.global_position.x -200 - (i *50),
	#			player.global_positon.y - 30
	#		)
	#	add_child(clone)


func _on_barrier_area_body_entered(body: Node2D):
	if body.name == "Player" or body == %Player:
		gameover()



func gameover():
	if gameovertrigger:
		return
	ghosts += 1
	emit_signal("ghosts_changed")
	text.visible = true
	$"UI Canvas/Header".text = "YOU LOSE"
	save_data()


func ghostupd():
	if ghosts == 1:
		ghost1.visible = true
		ghost2.visible = false
		ghost3.visible = false
		ghost4.visible = false
		ghost5.visible = false
		ghost2.queue_free()
		ghost3.queue_free()
		ghost4.queue_free()
		ghost5.queue_free()
	elif ghosts == 2:
		ghost1.visible = true
		ghost2.visible = true
		ghost3.visible = false
		ghost4.visible = false
		ghost5.visible = false
		ghost3.queue_free()
		ghost4.queue_free()
		ghost5.queue_free()
	elif ghosts == 3:
		ghost1.visible = true
		ghost2.visible = true
		ghost3.visible = true
		ghost4.visible = false
		ghost5.visible = false
		ghost4.queue_free()
		ghost5.queue_free()
	elif ghosts == 4:
		ghost1.visible = true
		ghost2.visible = true
		ghost3.visible = true
		ghost4.visible = true
		ghost5.visible = false
		ghost5.queue_free()
	elif ghosts >= 5:
		ghost1.visible = true
		ghost2.visible = true
		ghost3.visible = true
		ghost4.visible = true
		ghost5.visible = true



func _on_ghost_area_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
		gameovertrigger = true


func win():
	text.visible = true
	$"UI Canvas/Header".text = "YOU WIN"

func _on_ghost_area_1_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
		gameovertrigger = true




func _on_ghost_area_2_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
		gameovertrigger = true





func _on_ghost_area_3_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
		gameovertrigger = true





func _on_ghost_area_4_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
		gameovertrigger = true
