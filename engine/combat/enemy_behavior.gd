extends Enemy_Movement

class_name Enemy_Behavior

var behavior := "follow" setget _change_behavior
var navnode : Node 
var player : Node
var vision_range : int setget _change_vision_range
var tick_time : float setget _change_tick
var aggro_time : float setget _change_aggro


#Tick Timer
var tick_timer_set = false
var tick_timer := Timer.new()

func _change_tick(time : float):
	if not tick_timer_set:
		tick_timer.connect("timeout",self,"_on_tick")
		tick_timer.name = "tick_timer"
		add_child(tick_timer)
		tick_timer.start()
	tick_timer.wait_time = time
	tick_timer_set = true

#Aggro Timer
var aggro := false
var aggro_timer_set = false
var aggro_timer := Timer.new()

func _change_aggro(time : float):
	if not tick_timer_set:
		aggro_timer.one_shot = true
		aggro_timer.connect("timeout",self,"_on_aggro_end")
		add_child(aggro_timer)
		aggro_timer.start()
	aggro_timer.wait_time = time
	aggro = true

func _on_aggro_end():
	aggro = false

#behavior change

func _change_behavior(b : String) -> void:
	if self.has_method(b):
		behavior = b
	else:
		behavior = "follow"
		print("behavior doesnt exist : " + b)

#vision area
var vision_circle := CircleShape2D.new()
var vision_shape := CollisionShape2D.new()
var vision_set := false

func _change_vision_range(vision : int) -> void:
	if not vision_set:
		var vision_area := Area2D.new()
		add_child(vision_area)
		vision_area.add_child(vision_shape)
	vision_set = true
	vision_circle.radius = vision
	vision_shape.shape = vision_circle


func _on_tick() -> void:
	call(behavior)

#behaviors 
func follow() -> void:
	if !player and !navnode:
		return
	if _aim():
		dir = _get_path() - self.position
		dir = dir.normalized()
	else:
		#not visible
		dir = Vector2(0,0)


#complex behavior
var stay : int
var follow : int
var stop_follow : int
var random_follow : int
var random : int

const complex_args : Array= ["stay","follow","stop_follow","random_follow","random","aggro_time","tick_time","vision_range"]

func complex() -> void:
	if !player and !navnode and !_args_exists(complex_args):
		return
	if _aim():
		aggro = true
		aggro_timer.start()

	if aggro:
		var chance = stop_follow + follow + random_follow
		chance = hlp.randomI(1,chance)
		if chance <= stop_follow:
			dir = Vector2(0,0)
		elif chance <= stop_follow + follow:
			dir = _get_path() - self.position
			dir = dir.normalized()
		else:
			dir = hlp.randomDirV() 
	else:
		var chance = stay + random
		chance = hlp.randomI(1,chance)
		if chance >= stay:
			dir = Vector2(0,0)
		else:
			dir = hlp.randomDirV()
		
	
#behavior tools
func _args_exists(arr : Array) -> bool:
	for arg in arr:
		if !self.get(arg):
			return false
	return true

func _get_path() -> Vector2:
	if !navnode and !player:
		return Vector2(0,0)
	var path = navnode.get_simple_path(self.position,player.position)
	for point in path:
		if self.position == point:
			path.remove(0)
			point = path[0]
	return path[0]

func _aim() -> bool:
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(self.global_position,player.global_position,[self],1 || 3)
	if result:
		if result.collider.collision_layer == 1:
			return true
	return false
