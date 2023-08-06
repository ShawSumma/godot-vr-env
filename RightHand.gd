extends XRController3D

var last = false

func _ready():
	pass
	
func object():
	return get_node("FunctionPickup").picked_up_object
		
func _process(delta):
	var cur = is_button_pressed("ax_button")
	if cur and not last:
		var obj = object()
		var lines = get_node("../Lines")
		lines.set_select(obj)
	last = cur
