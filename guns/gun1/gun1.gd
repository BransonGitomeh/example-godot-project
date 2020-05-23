extends Gun


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 1
	random_spread = false
	spread = 30
	shots_per_cone = 3
	burst = 1
	self.burst_time = 0.05
	self.firerate = 0.4
	projectile = preload("res://projectiles/sine/sine.tscn")
	"""
	var firerate : float
	var damage : int
	var random_spread : bool
	var spread : int #degrees
	var shots_per_cone : int
	var burst : int
	var burst_time : int
	var projectile : PackedScene
	"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
