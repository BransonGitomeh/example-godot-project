extends KinematicBody2D

class_name Projectile

var damage : int 
var speed : int
var dir : Vector2 setget _set_dir
var type : bool setget _set_type #true = player, flase = enemy 
var norm : Vector2
var puttern : Array setget _set_puttern
var offsetter : Node
var static := false

func _set_type(t : bool) -> void:
	type = t
	self.collision_layer = hlp.bit(4)
	if t:
		self.collision_mask = hlp.bit(2) + hlp.bit(3)
	else:
		self.collision_mask = hlp.bit(1) + hlp.bit(3)
		

func _ready() -> void:
	damage_timer_setup()

func _set_dir(direction : Vector2):
	dir = direction.normalized()
	if dir.x < 0:
		norm = dir.rotated(PI/2)
	else:
		norm = dir.rotated(-PI/2)
#mooving
var time: float = 0

func _physics_process(delta) -> void:
	delta *= speed
	var prev_time : float = time
	time += delta

	var d = _get_on_puttren(time) - _get_on_puttren(prev_time)
	var new_dir = dir * delta + norm * d
	if static:
		new_dir = Vector2.ZERO
	var collision = move_and_collide(new_dir + _get_offset(time) - _get_offset(prev_time))
	if collision:
		collision(collision.collider)
	else:
		pass

##############################################################################
#mooving putturns
var loop : float

func _set_puttern(arr : Array) -> void: #[function,length]
	if arr.size() > 0:
		puttern = arr
	for f in arr:
		loop += f[1]
	loop = round(loop)

func _get_on_puttren(x : float) -> float:
	if puttern:
		if loop > 0:
			var n = fposmod(x,loop)
			if floor(n) == floor(loop):
				n = loop
			var m := 0
			var current : Node
			for f in puttern:
				m += f[1]
				if m >= n - 1:
					current = f[0]
					break
			return current.get_y(n)
		else:
			return puttern[0][0].get_y(x)
	else:
		return 0.0
	

func _get_offset(t : float) -> Vector2:
	if offsetter:
		return offsetter.get_offset(t)
	else:
		return Vector2(0,0)

##############################################################################

var damage_timer : Timer = Timer.new()
const damage_wait_time : float = 0.5
var can_damage := true
 
func collision(body) -> void:
	if can_damage:
		if type:
			if body is Enemy:
				body.hurt(damage)
				on_hit()
		else:
			if body.collision_layer == 0: #player
				body.hurt(damage)
				on_hit()
		self.queue_free()



func on_hit() -> void:
	can_damage = false
	damage_timer.start()

func damage_timer_setup() -> void:
	damage_timer.wait_time = damage_wait_time
	damage_timer.one_shot = true
	damage_timer.connect("timeout",self,"_on_damage_coldown")
	add_child(damage_timer)

func _on_damage_coldown() -> void:
	can_damage = true
