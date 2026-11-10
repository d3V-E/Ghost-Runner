extends Node2D


var speed = 200
var barrierwidth = 360
var barriercount = []
var barriery = 0

@onready var red = $"Red Barrier"

func _ready():
	barriercount.append(red)
	barriery = red.global_position.y - 360


func _process(delta):
	var player = %Player
	if player.global_position.y <= barriery:
		duplicateheight()
	if player:
		var direction = 1
		global_position.x += direction * speed * delta


func duplicateheight():
	var cloneht = red.duplicate()
	cloneht.global_position.y = barriery
	add_child(cloneht)
	barriercount.append(cloneht)
	red = cloneht
	barriery -= 360
	if barriercount.size() > 3:
		var oldbar = barriercount.pop_front()
		oldbar.queue_free()
