extends Projectile


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.puttern = [[Sin_Wave.new(),0]] #[function,length]
	speed = 180
	damage = 1
	self.type = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
