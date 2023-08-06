extends Node3D

var pairs = []
var index = 0
var selects = [null, null]
var colors = {}

func _ready():
	pass

func line(a, b, thickness):
	var mesh = load("res://Cylinder.tscn").instantiate()
	add_child(mesh)
	mesh.global_position = (a+b)/2
	mesh.scale = Vector3(0.01*thickness, 0.01*thickness, a.distance_to(b))
	mesh.look_at_from_position((a+b)/2, b)

func get_text(obj):
	return obj.find_child("Value").text
	
func set_text(obj, text):
	if obj.name == "Slider":
		return
	obj.find_child("Value").text = text

func get_mat(obj):
	return obj.find_child("Mesh").get_surface_override_material(0)

func set_mat(obj, mat):
	obj.find_child("Mesh").set_surface_override_material(0, mat)

func set_obj(n, obj, color):
	n %= 2
	selects[n] = obj
	if obj not in colors:
		colors[obj] = []
	var mat = get_mat(obj)
	colors[obj].append(mat)
	var std = mat.duplicate()
	std.albedo_color = color
	set_mat(obj, std)

func reset(n):
	n %= 2
	var obj = selects[n]
	set_mat(selects[n], colors[obj].pop_back())
	set_text(selects[n], "1")
	selects[n] = null
	

func set_select(obj):
	if obj == null:
		return
	if index % 2 == 0:
		set_obj(index, obj, Color(0, 1, 0))
	else:
		set_obj(index, obj, Color(0, 0, 1))
	if selects[0] != null and not selects[0].is_inside_tree():
		selects[0] = null
	if selects[1] != null and not selects[1].is_inside_tree():
		selects[1] = null
	index += 1
	if selects[0] == selects[1]:
		index = 0
		selects[index % 2].print_tree_pretty()
		reset(index)
	if selects[0] != null && selects[1] != null:
		var gone = false
		for pair in pairs:
			if (pair[0] == selects[0] and pair[1] == selects[1]) or (pair[0] == selects[1] and pair[1] == selects[0]):
				pairs.erase(pair)
				gone = true
				break
		if not gone:
			pairs.append([selects[0], selects[1]])
		reset(0)
		reset(1)
		index = 0

func is_prime(n):
	if n % 2 == 0:
		return false
	var m = 3
	while m * m <= n:
		if n % m == 0:
			return false
		m += 2
	return true 

func _process(_delta):
	var next_pairs = []
	for pair in pairs:
		if pair[0].is_inside_tree() and pair[1].is_inside_tree():
			next_pairs.append(pair)
	pairs = next_pairs
	for child in get_children():
		remove_child(child)
	var input_nodes = {}
	var output_nodes = {}
	for pair in pairs:
		input_nodes[pair[0]] = pair[1]
		if pair[1] not in output_nodes:
			output_nodes[pair[1]] = []
		output_nodes[pair[1]].append(pair[0])
	for i in output_nodes:
		set_text(i, "")
	var bad = true
	while bad:
		bad = false
		for i in output_nodes:
			var math = i.find_child("Math")
			if math == null:
				continue
			var inputs = []
			for j in output_nodes[i]:
				var txt = get_text(j)
				if txt == "":
					bad = true
					continue
				inputs.append(txt)
			set_text(i, math.calc(inputs))
	for pair in pairs:
		line(pair[0].global_position, pair[1].global_position, 0.5)
