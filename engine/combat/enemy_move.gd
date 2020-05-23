extends Entity

class_name Enemy_Movement

var speed := 0.0 
var dir := Vector2.ZERO 
var real_dir := Vector2.ZERO
var distance := 0.0
var movement_method : String = "linear" setget _change_method
var dir_lock := 0.0 setget _change_dir_lock
var dir_lock_timer : Timer = Timer.new()
var move_loop_mod : float = 1


func _change_dir_lock(time : float) -> void:
	dir_lock_timer.wait_time = time
	dir_lock_timer.start()

func _ready() -> void:
	dir_lock_timer.connect("timeout",self,"_on_dir_lock")
	add_child(dir_lock_timer)

func _on_dir_lock() -> void:
	real_dir = dir

func _change_method(method : String) -> void:
	if self.has_method(movement_method):
		movement_method = method
	else:
		movement_method = "linear"
		print("no movment method found : " + method)

func _physics_process(delta) -> void:
	distance += delta*speed/move_loop_mod
	var new_speed : float = callv(movement_method,[distance])*speed
	move_and_slide(real_dir * new_speed)

func xby2(d : float) -> float:
	d = fposmod(d,2) 
	d -=1
	return abs(1 - d*d)

func xby4(d : float) -> float:
	d = fposmod(d,2) 
	d -=1
	return abs(1-pow(d,4))

func linear(_d : float) -> float:
	return 1.0

func get_collision() -> Array:
	if get_slide_count() > 0:
		var arr := []
		for i in range(get_slide_count()):
			arr.append(get_slide_collision(i))
		return arr
	else:
		return []


