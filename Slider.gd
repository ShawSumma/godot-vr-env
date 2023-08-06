extends Node3D

var slices = 16
var xscale = 16
var value = 0

func _ready():
	pass

func _process(_delta):
	var object = get_parent()
	var slider = object.get_parent()
	var mesh = object.get_node("Mesh")
	value = floor((object.global_position.y - slider.global_position.y) * slices) / slices * xscale
	self.text = str(value)

func get_num():
	return value
