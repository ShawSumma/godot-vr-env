extends XRController3D

var ax_last = false
var by_last = false

func _ready():
	pass
	
func _process(_delta):
	var ax_cur = is_button_pressed("ax_button")
	var by_cur = is_button_pressed("by_button")
	if ax_cur and not ax_last:
		var scene = load("res://Select.tscn")
		var inst = scene.instantiate()
		get_node("../Selects").add_child(inst)
		inst.look_at(get_node("../XRCamera3D").global_position)
		inst.position = position
	if by_cur and not by_last:
		get_node("../Lines").set_select(get_node("FunctionPickup").picked_up_object)
	by_last = by_cur
	ax_last = ax_cur
