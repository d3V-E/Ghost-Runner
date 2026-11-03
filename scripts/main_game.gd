extends Node2D

@onready var player = $"Main Player"
@onready var part = $"Visual Ground"

var partwidth = 640



func _ready():
	pass

func _process(_delta):
	if player.global_position.x > part.global_position.x:
		duplicatepart()

func duplicatepart():
	var clone = part.duplicate()
	clone.global_position.x = part.global_position.x + partwidth
	clone.global_position.y = part.global_position.y
	add_child(clone)
	part = clone



func _on_test_timeout():
	print(player.global_position.x)
