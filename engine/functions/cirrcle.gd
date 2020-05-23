extends Node

class_name Circle_Wave

const MODIFIER : float = 40.0

func get_y(x : float) -> float:
	x = x/MODIFIER
	x = fmod(x,2) - 1
	return (sqrt(1 - x*x) - 0.5) * MODIFIER
