extends Node2D

@export var offset: Vector2 = Vector2(200, 0)  # cuánto se moverá desde el punto inicial
@export var speed: float = 100.0

var point_a: Vector2
var point_b: Vector2
var moving_to_b := true

func _ready():
	point_a = global_position
	point_b = point_a + offset

func _process(delta):
	var target = point_b if moving_to_b else point_a
	var direction = (target - global_position).normalized()
	global_position += direction * speed * delta

	if global_position.distance_to(target) < 5:
		moving_to_b = !moving_to_b
