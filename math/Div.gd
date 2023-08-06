extends Node

func calc(arr):
	if arr.size() == 1:
		return str(1/float(arr[0]))
	var ret = float(arr[0])
	for i in arr.slice(1):
		ret /= float(i)
	return str(ret)
