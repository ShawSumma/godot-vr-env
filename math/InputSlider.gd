extends Node3D

var slices = 16
var xscale = 16
var value = 0

func _ready():
	pass

func _process(_delta):
	var object = get_parent()
	var slider = object.get_parent()
	value = floor((object.global_position.y - slider.global_position.y) * slices) / slices * xscale
	self.text = str(value)
	var old = self.global_position
	self.look_at_from_position(
		get_node("/root/root/XROrigin3D/XRCamera3D").global_position,
		self.global_position,
		Vector3(0, 1, 0)
	)
	self.global_position = old
