extends Area2D

@export var wall_path: NodePath  # Exporta para conectar a la pared desde el editor

func _on_body_entered(body):
	if body.name == "player":
		if wall_path:
			var wall = get_node(wall_path)
			wall.queue_free()  # Destruye la pared
		queue_free()  # Destruye la llave
