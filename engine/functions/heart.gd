extends Node

class_name Heart_Wave

const WIDTH: float = 2.0
const MODIFIER : float = 50.0

# func get_y(x: float) -> float:
# 	return MODIFIER_Y * func(x / MODIFIER_X)

func get_offset(time : float) -> Vector2:
	return func(time/MODIFIER)*MODIFIER


func func(x: float) -> Vector2:
	x = fposmod(x, WIDTH*2)
	if x > WIDTH: # Bottom part
		x -= WIDTH * 1.5
		return Vector2(-x,-sqrt(abs(x))/1.5 + sqrt(1 - x*x))
	else: # Top part
		x -= WIDTH/2
		return Vector2(x,-sqrt(abs(x))/1.5 - sqrt(1 - x*x))