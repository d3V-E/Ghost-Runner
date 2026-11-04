extends Node2D

@onready var player = $"Main Player"
@onready var part = $"Visual Ground"
@onready var background = $"Visual Ground/BackgroundSky"

var partwidth = 640
var partheight = 360


func _ready():
	pass

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
