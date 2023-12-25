extends Node

var logger = LogStream.new("MainGlobal")

var current_scene: Node
var axis: Vector2

func _ready():
  logger.info("ready")

  var root = get_tree().get_root()

  current_scene = root.get_child(root.get_child_count() - 1)

func get_axis() -> Vector2:
  var input = Input.get_axis("ui_left", "ui_right")

  print(input)

  return axis
