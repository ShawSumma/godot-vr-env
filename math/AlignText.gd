extends Node3D

func _ready():
	pass
	
func _process(_delta):
	var old = self.global_position
	self.look_at_from_position(
		get_node("/root/root/XROrigin3D/XRCamera3D").global_position,
		self.global_position,
		Vector3(0, 1, 0)
	)
	self.global_position = old
