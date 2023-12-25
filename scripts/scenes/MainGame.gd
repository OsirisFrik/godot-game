extends Node2D
class_name MainGame

var screen_size: Vector2
var hearts: Array[Heart] = []

func _ready():
  screen_size = get_window().size

func _process(_delta):
  if Input.is_action_just_pressed("game_reset"):
    get_tree().reload_current_scene()
