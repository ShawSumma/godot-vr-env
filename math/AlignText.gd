extends Node3D

func _ready():
	pass
	
func _process(_delta):
	var par = get_parent()
	var old = par.global_position
	par.look_at_from_position(
		get_node("/root/root/XROrigin3D/XRCamera3D").global_position,
		self.global_position,
		Vector3(0, 1, 0)
	)
	par.global_position = old
