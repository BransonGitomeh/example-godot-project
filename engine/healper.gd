extends Node

func randomI(from : int,to : int) -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(from,to)

func randomF(from : float,to : float) -> float:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randf_range(from,to)

func randomDirV() -> Vector2:
	randomize()
	var x := randf()
	randomize()
	var y := randf()
	return Vector2(x,y).normalized()


func seedI(from : int,to : int,r_seed : int):
	var rng = RandomNumberGenerator.new()
	rng.set_seed(r_seed)
	return rng.randi_range(from,to)

func bit(num : int):
	return pow(2,num - 1)