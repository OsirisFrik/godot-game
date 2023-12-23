extends Node2D
class_name Trap

@export var type = ''

func _on_saw_body_entered_node(body):
  if body as Player:
    body.hit()
