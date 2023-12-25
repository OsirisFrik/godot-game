extends Node2D
class_name Heart

@onready var sprite = $Sprite
var value: float = 1.0

func _ready():
  print("ready")
  sprite.play("appear")

  print(sprite.is_playing())

func hit(damage: int):
  value -= damage

  print(value is float)
