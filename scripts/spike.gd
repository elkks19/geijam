extends Area2D
class_name Spike

func _on_body_entered(body):
	if body.name == "player":  # Solo si tienes un sonido
		body.die()     # Llama a la función de muerte del jugador
