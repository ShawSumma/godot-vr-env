extends Node

func calc(arr):
	var n = 1
	for i in arr:
		n *= float(i)
	return str(n)
