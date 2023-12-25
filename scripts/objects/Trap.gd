extends Node2D
class_name Trap

## use .5 range
@export var damage: float = 1

func _on_saw_body_entered_node(body):
  if body as Player:
    body.hit(damage)
