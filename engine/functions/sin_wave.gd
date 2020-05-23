extends Node

class_name Sin_Wave

const MODIFIER : float = 40.0 #resize

func get_y(x : float) -> float:
	return sin(x/MODIFIER) * MODIFIER
