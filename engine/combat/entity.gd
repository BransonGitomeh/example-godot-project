extends KinematicBody2D

class_name Entity

signal die

var maxhealth : int setget _change_maxhealth
var health : int

func _ready():
	self.connect("die",self,"_on_death")

func hurt(damage : int) -> void:
	health -= damage
	if health <= 0:
		self.queue_free()
		emit_signal("die")

func heal(amount : int) -> void:
	health += amount
	if health > maxhealth:
		health = maxhealth

func _change_maxhealth(he : int) -> void:
	health = he
