extends Sprite 

class_name Gun

var firerate : float setget _change_firerate
var damage : int
var random_spread : bool
var spread : int #degrees
var shots_per_cone : int
var burst : int
var burst_time : float setget _change_burst_time
var projectile : PackedScene


var current_dir : Vector2
var new_burst : int

var burst_timer := Timer.new()
var can_shoot := true
var coldown_timer := Timer.new()

onready var main_game_node = get_tree().get_root().get_node("/root/main_game")

func _change_burst_time(time : float) -> void:
	burst_time = time
	burst_timer.wait_time = time
	burst_timer.start()

func _change_firerate(time : float) -> void:
	firerate = time
	coldown_timer.wait_time = time
	coldown_timer.start()

func _burst_setup() -> void:
	burst_timer.one_shot = true
	burst_timer.connect("timeout",self,"_on_burst")
	add_child(burst_timer)

func _firerate_setup() -> void:
	coldown_timer.one_shot = true
	coldown_timer.connect("timeout",self,"_on_coldown")
	add_child(coldown_timer)

func _burst(dir : Vector2) -> void:
	if !can_shoot:
		return
	var projectiles := []
	for split in _split(spread/2,-spread/2,shots_per_cone - 1):
		if random_spread:
			projectiles.append(_random_spread(split.x,split.y))
		else:
			projectiles.append(Vector2(cos(deg2rad((split.y+split.x)/2)),sin(deg2rad((split.y+split.x)/2))))
	for p in projectiles:
		var shot = projectile.instance()
		shot.dir = p.rotated(dir.angle())
		shot.damage = damage
		shot.position = get_parent().position
		main_game_node.add_child(shot)
	new_burst -= 1
	if new_burst > 0:
		burst_timer.start()
	else:
		coldown_timer.start()
		can_shoot = false

func shoot(dir : Vector2) -> void:
	if !can_shoot:
		return
	current_dir = dir
	new_burst = burst
	_burst(current_dir)
	new_burst -= 1
	burst_timer.start()

func _on_burst():
	_burst(current_dir)

func _split(num1 : int,num2 : int,sp : int) -> Array:
	var splits := []
	var last_point : float  = num1
	var change : float = (num2-num1)/sp
	var new_point : float = last_point+change
	for i in range(sp):
		splits.append(Vector2(last_point,new_point))
		last_point += change
		new_point += change
	return splits

func _random_spread(num1 : int,num2 :int) -> Vector2:
	var rad : float = hlp.randomF(deg2rad(num1),deg2rad(num2))
	return Vector2(cos(rad),sin(rad))

func _ready() -> void:
	_firerate_setup()
	_burst_setup()

func _on_coldown() -> void:
	can_shoot = true