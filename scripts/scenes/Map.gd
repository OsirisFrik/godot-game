extends Node2D
class_name Map

@export var cooldown_timeout = 2.0

var screen_size: Vector2i
var cooldown: bool = false
var timeout = Timer.new()

func _init():
  print(cooldown_timeout)
  timeout.wait_time = cooldown_timeout
  timeout.one_shot = true

  timeout.connect("timeout", _on_cooldown_end)

  add_child(timeout)

func _ready():
  screen_size = get_window().size

func _process(_delta):
  if Input.is_physical_key_pressed(KEY_R) && !cooldown:
    cooldown = true
    timeout.start()

    var x = TileGenerator.generate_tile(3, 3, 2, Vector2i(2, -3), 1)

    $TileMap.set_cells_terrain_path(0, x, 0, 0)

    print(x)

func _on_cooldown_end():
  print("cooldown end", cooldown_timeout)
  cooldown = false


func _on_player_player_tilemap(coords: Vector2, _direction: float, looking: float):
  var map = TileGenerator.generate_tile(2, 2, 2, coords, looking)

  print(coords)

  print(map)

  $TileMap.set_cells_terrain_path(0, map, 0, 0)
