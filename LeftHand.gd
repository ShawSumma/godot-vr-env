extends XRController3D

var ax_last = false
var by_last = false

func _ready():
	pass
	
func _process(delta):
	var ax_cur = is_button_pressed("ax_button")
	var by_cur = is_button_pressed("by_button")
	if ax_cur and not ax_last:
		var scene = load("res://Platter.tscn")
		var inst = scene.instantiate()
		get_node("../Nodes").add_child(inst)
		inst.look_at(get_node("../XRCamera3D").global_position)
		inst.position = position
	if by_cur and not by_last:
		var scene = load("res://Slider.tscn")
		var inst = scene.instantiate()
		get_node("../Nodes").add_child(inst)
		inst.look_at(get_node("../XRCamera3D").global_position)
		inst.position = position
	by_last = by_cur
	ax_last = ax_cur
