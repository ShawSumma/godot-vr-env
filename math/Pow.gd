extends Node

func calc(arr):
	if arr.size() == 0:
		return 1
	var n = float(arr[0])
	for i in arr.slice(1):
		n = pow(n, float(i))
	return str(n)
