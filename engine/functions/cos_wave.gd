extends Node

class_name Cos_Wave

const MODIFIER : float = 20.0

func get_y(x : float) -> float:
	return cos(x/MODIFIER) * MODIFIER
