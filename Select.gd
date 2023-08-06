extends Node3D

var size = 0.2
var rot = 0

func orbit(time):
	rot += time
	var angle = TAU / get_child_count()
	var n = 0
	for chh in get_children():
		for ch in chh.get_children():
			ch.position = Vector3(
				cos(n * angle + rot) * size,
				sin(n * angle + rot) * size,
				0,
			)
			n += 1

func _ready():
	var parent = get_parent()
	var removed = 0
	for ch in parent.get_children():
		if ch != self:
			parent.remove_child(ch)
			removed += 1
	if removed != 0:
		return
	for ch in get_children():
		var sub = Node3D.new()
		add_child(sub)
		remove_child(ch)
		sub.add_child(ch)
	orbit(0)

func _process(delta):
	orbit(delta / 3)
	var origin = get_node("/root/root/XROrigin3D")
	self.look_at(origin.get_node("XRCamera3D").global_position)
	for hand_name in ["LeftHand", "RightHand"]:
		var hand = origin.get_node(hand_name)
		var obj = hand.get_node("FunctionPickup").picked_up_object
		if obj == null:
			continue
		obj = obj.get_parent()
		if is_ancestor_of(obj):
			obj.get_parent().remove_child(obj)
			get_node("/root/root/XROrigin3D/Nodes").add_child(obj)
			obj.global_position = get_node("/root/root/XROrigin3D/LeftHand").global_position
			get_parent().remove_child(self)
			break
