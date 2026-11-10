extends Node2D

@onready var player = $"Player"
@onready var part = $"Visual Ground"
@onready var background = $"Visual Ground/BackgroundSky"
@onready var barrier = $"Barrier Node/Red Barrier"
@onready var ghostuser = $Ghost
@onready var text = $"UI Canvas/Header"

@onready var ghost1 = $Ghost
@onready var ghost2 = $Ghost1
@onready var ghost3 = $Ghost2
@onready var ghost4 = $Ghost3
@onready var ghost5 = $Ghost4


const save_path = "user://userdata.savesss"

signal ghosts_changed


var runs = 0
var gameovertrigger = false
var partcount = []
var backgroundcount = []
var partwidth = 640
var partheight = 360
var time = 6000
var ghosts = 1
var trackx = 0
var tracky = 0

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
	trackx = part.global_position.x + partwidth
	tracky = background.global_position.y - partheight
	#ghostduplicate()

func _process(_delta):
	@warning_ignore("integer_division")
	if player.global_position.x >= trackx - (partwidth - 100):
		duplicatepart()
	@warning_ignore("integer_division")
	if player.global_position.y <= tracky + (partheight / 2):
		duplicatebackground()

func duplicatepart():
	if partcount[-1].global_position.x >= trackx:
		return
	var clone = part.duplicate()
	clone.global_position.x = trackx
	clone.global_position.y = part.global_position.y
	clone.z_index = 0
	add_child(clone)
	partcount.append(clone)
	part = clone
	trackx += partwidth
	if partcount.size() > 3:
		var oldpart = partcount.pop_front()
		oldpart.queue_free()


func duplicatebackground():
	var cloneb = background.duplicate()
	cloneb.global_position.x = background.global_position.x
	cloneb.global_position.y = tracky
	cloneb.z_index = -1
	add_child(cloneb)
	backgroundcount.append(cloneb)
	background = cloneb
	tracky -= partheight
	if backgroundcount.size() > 3:
		var oldb = backgroundcount.pop_front()
		oldb.queue_free()


#func _on_test_timeout():
	#print(player.global_position.x)
	#print(player.global_position.y)





func _on_timer_timeout():
	if time <= 0:
		time = 0
		$"UI Canvas/Timer Text".text = "00 : 00 : 00"
		win()
	else:
		time -= 1
		@warning_ignore("integer_division")
		var minute = int(time / 6000)
		@warning_ignore("integer_division")
		var seconds = int(time / 100)% 60
		var centi = int(time) % 100
		$"UI Canvas/Timer Text".text = "%02d : %02d : %02d" % [minute , seconds , centi]

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
	$"UI Canvas/Timer Image/Timer".stop()
	text.visible = true
	$"UI Canvas/Header".text = "YOU LOSE"
	save_data()
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()


func ghostupd():
	ghosts = clamp(ghosts, 1,5)
	ghost1.visible = (ghosts >= 1)
	ghost2.visible = (ghosts >= 2)
	ghost3.visible = (ghosts >= 3)
	ghost4.visible = (ghosts >= 4)
	ghost5.visible = (ghosts >= 5)


func _on_ghost_area_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
			print("1")
		gameovertrigger = true


func win():
	text.visible = true
	$"UI Canvas/Header".text = "YOU WIN"
	$"UI Canvas/Timer Image/Timer".stop()
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()

func _on_ghost_area_1_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
			print("2")
		gameovertrigger = true




func _on_ghost_area_2_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
			print("3")
		gameovertrigger = true





func _on_ghost_area_3_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
			print("4")
		gameovertrigger = true





func _on_ghost_area_4_body_entered(body: Node2D):
	if body.name == "Player":
		if gameovertrigger == false:
			gameover()
			print("5")
		gameovertrigger = true
