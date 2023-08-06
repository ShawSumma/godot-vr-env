extends Node

func calc(arr):
	var n = 0
	for i in arr:
		n += float(i)
	return str(n)
