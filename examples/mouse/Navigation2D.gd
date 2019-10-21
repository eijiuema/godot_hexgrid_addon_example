
extends Navigation2D

onready var hextilemap = $HexTileMap
onready var highlight = $Highlight
onready var line = $Line2D
onready var player = $Player

var path : PoolVector2Array
var goal : Vector2

export var speed := 250

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left_click"):
		goal = hextilemap.get_hex_center(hextilemap.world_to_map((get_global_mouse_position())))
		path = get_simple_path(player.position, goal, false)
		line.points = PoolVector2Array(path)
		line.show()

func _process(delta: float) -> void:
	
	var selected_cell = hextilemap.world_to_map(get_global_mouse_position())
	highlight.position = hextilemap.map_to_world(selected_cell)
		
	if !path:
		line.hide()
		return
	if path.size() > 0:
		var d: float = player.position.distance_to(path[0])
		if d > 5:
			player.position = player.position.linear_interpolate(path[0], (speed * delta)/d)
		else:
			path.remove(0)