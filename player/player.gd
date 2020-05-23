extends Entity

class_name Player

const max_health = 20
var stanned : bool = false
var sine_scene = preload("res://projectiles/sine/sine.tscn")
const speed : int = 100
var dir := Vector2.ZERO



func _input_manager() -> void:
	if not stanned:
		dir = _movement_input()
	if Input.is_action_just_pressed("attack"):
		var d := get_global_mouse_position()
		d = d - self.position
		d = d.normalized()
		$gun1.shoot(d)

func _movement_input() -> Vector2:
	var movement := Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		movement += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		movement += Vector2.RIGHT
	if Input.is_action_pressed("move_up"):
		movement += Vector2.UP
	if Input.is_action_pressed("move_down"):
		movement += Vector2.DOWN
	return movement.normalized()

func _process(_delta) -> void:
	_input_manager()

func _physics_process(delta) -> void:
	move_and_slide(dir * speed)

func _on_death() -> void:
	self.queue_free()
