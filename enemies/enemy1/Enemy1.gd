extends Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 120.0
	self.maxhealth = 10
	stay = 10
	follow = 10
	stop_follow = 0
	random_follow = 5
	random = 5
	navnode = get_parent().get_node("map/Navigation2D")
	player = get_parent().get_node("player")
	self.aggro_time = 3.0
	self.behavior = "complex"
	self.tick_time = 0.5
	self.vision_range = 100
	self.movement_method = "xby4"
	self.dir_lock = 1
	self.move_loop_mod = 60 #speed/dir_lock * 2 



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
