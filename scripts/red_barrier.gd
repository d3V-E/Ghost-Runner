extends Node2D


var speed = 200
var barrierwidth = 360


@onready var red = $"Red Barrier"

func _ready():
	pass



func _process(delta):
	var player = %Player
	if player.global_position.y > red.global_position.y:
		duplicateheight()
	if player:
		var direction = 1
		global_position.x += direction * speed * delta


func duplicateheight():
	var cloneht = red.duplicate()
	cloneht.global_position.y = red.global_position.y
	add_child(cloneht)
	red = cloneht
