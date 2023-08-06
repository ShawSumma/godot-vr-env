extends XRController3D

var ax_last = false
var by_last = false

func _ready():
	pass

func object():
	return get_node("FunctionPickup").picked_up_object

func _process(_delta):
	var ax_cur = is_button_pressed("ax_button")
	var by_cur = is_button_pressed("by_button")
	if by_cur and not by_last:
		var obj = object()
		if obj != null:
			obj.get_parent().remove_child(obj)
	by_last = by_cur
	ax_last = ax_cur
