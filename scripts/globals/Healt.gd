extends Node

signal  player_live_change

enum LiveChange {
  add,
  sub
}

var uiNode = Node.new()
var _lives = 3
var current_scene

func _ready():
  var root = get_tree().get_root()

  current_scene = root.get_child(root.get_child_count() - 1)

  current_scene.add_child(uiNode)

  if current_scene._on_global_ready is Callable:
    current_scene._on_global_ready("healt")

func get_lives() -> int:
  return _lives

func sub_live(lives: int) -> int:
  _lives -= lives

  player_live_change.emit(LiveChange.sub, lives)

  return _lives

func add_live(lives: int) -> int:
  _lives += lives

  return _lives

func load_hearts():
  var lives = 3

  print(lives)

  for i in range(lives):
    var heart = Heart.new()

    heart.position = Vector2(2, 3)

    
    pass
