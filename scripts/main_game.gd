extends Node2D

@onready var player = $"Player"
@onready var part = $"Visual Ground"
@onready var background = $"Visual Ground/BackgroundSky"
@onready var barrier = $"Visual Ground/Red Barrier"
@onready var ghostuser = $Ghost


const save_path = "user://userdata.savefile"

signal ghosts_changed

var partwidth = 640
var partheight = 360
var time = 30000
var ghosts = 10


func save_data():
	var data = {
		"ghosts": ghosts
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
		else:
			save_data()


func _ready():
	load_data()
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
	part = clone

func duplicatebackground():
	var cloneb = background.duplicate()
	cloneb.global_position.x = background.global_position.x
	cloneb.global_position.y = background.global_position.y - partheight
	cloneb.z_index = -1
	add_child(cloneb)
	background = cloneb


func _on_test_timeout():
	print(player.global_position.x)
	print(player.global_position.y)





func _on_timer_timeout():
	if time <= 0:
		time = 0
		$"UI Canvas/Timer Text".text = "00 : 00 : 00"
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
	print(body.name)
	if body.name == "Player" or body == %Player:
		print("Player Red")



func gameover():
	print("Game Over")
