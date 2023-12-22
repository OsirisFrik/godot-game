extends Node
class_name Main_Global

var axis: Vector2

func get_axis() -> Vector2:
  var input = Input.get_axis("ui_left", "ui_right")

  print(input)

  return axis
