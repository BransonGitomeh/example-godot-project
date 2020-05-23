extends Node2D

var path := "res://save"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const room_size = Vector2(50,30)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_room(pos : Vector2,closest_town : Vector2,biome : int):
	biome = 0 #temporerly
	var room = _open_room_file(pos)
	if !room:
		room = _create_room(pos,round(pos.distance_to(closest_town)/2),biome)
	return _generate_room(room)

func _create_room(p : Vector2,dif : int,biome : int):
	randomize()
	var room = Room_Res.new()
	room.pos = p
	room.dif = dif
	room.biome = biome
	room.type = _room_type()
	room.entities = []
	room.room_seed = randi()
	ResourceSaver.save(path.plus_file(str(room.pos.x)+str(room.pos.y)+".res"),room)
	return room
	
func _room_type() -> int:
	var random : int = hlp.randomI(0,8)
	if random >= 2:
		return 1
	else:
		return 0

func _open_room_file(room_pos : Vector2):
	var file_list = _list_files_in_directory(path)
	for room in file_list:
		if ResourceLoader.exists(path.plus_file(room)):
			room = ResourceLoader.load(path.plus_file(room))
			if room.pos == room_pos:
				return room
	
func _list_files_in_directory(p) -> Array:
	var files = []
	var dir = Directory.new()
	dir.open(p)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files

func _generate_room(room : Resource):
	var tiles := []
	var s = room.room_seed
	for x in range(room_size.x):
		for y in range(room_size.y):
			tiles.append([Vector2(x,y),_asign_tile(s)])
			s -= 1
	return [tiles]
			
			
func _asign_tile(s : int) -> int:
	var random : int = hlp.seedI(1,100,s)
	if random <= 96:
		return 0
	else:
		return 1



