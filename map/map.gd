extends Node2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var tiles = $room_manager.get_room(Vector2(0,0),Vector2(0,0),0)[0]
	for tile in tiles:
		$Navigation2D/tilemap.set_cellv(tile[0],tile[1])




