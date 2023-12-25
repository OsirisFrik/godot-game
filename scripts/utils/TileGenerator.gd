extends Node
class_name TileGenerator

static func generate_tile(
  height: int,
  width: int,
  length: int,
  coords: Vector2i,
  dir: float
):
  var res: Array[Vector2i] = []

  for h in range(height):
    for l in range(length):
      var w = l if dir == 1 else width - l - 1
      var new_coords = Vector2i(coords.x + w, coords.y + h)
      if res.size() > 0:
        var last_coords = res[res.size() - 1]
        if abs(new_coords.x - last_coords.x) <= 1 and abs(new_coords.y - last_coords.y) <= 1:
          res.append(new_coords)
      else:
        res.append(new_coords)     

  return res
