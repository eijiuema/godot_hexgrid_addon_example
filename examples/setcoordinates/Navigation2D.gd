extends Navigation2D

onready var hextilemap = $HexTileMap
onready var line = $Line2D
onready var player = $Player

var path : PoolVector2Array
var goal : Vector2

export var speed := 250

var levels = [
	Vector2(-1, 0),
	Vector2(0, 2),
	Vector2(2, 1),
	Vector2(4, -1)
]

var currentLevel = 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		if (currentLevel < len(levels)):
			currentLevel += 1
			goal = hextilemap.get_hex_center(levels[currentLevel - 1])
			path = get_simple_path(player.position, goal, false)
			line.points = PoolVector2Array(path)
			line.show()
	if event.is_action_pressed("ui_left"):
		if (currentLevel > 1):
			currentLevel -= 1
			goal = hextilemap.get_hex_center(levels[currentLevel - 1])
			path = get_simple_path(player.position, goal, false)
			line.points = PoolVector2Array(path)
			line.show()

func _process(delta: float) -> void:
		
	if !path:
		line.hide()
		return
	if path.size() > 0:
		var d: float = player.position.distance_to(path[0])
		if d > 5:
			player.position = player.position.linear_interpolate(path[0], (speed * delta)/d)
		else:
			path.remove(0)