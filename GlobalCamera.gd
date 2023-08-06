extends XRCamera3D

var Global = preload("res://Global.tres")

func _ready():
	Global.set("camera", self)
