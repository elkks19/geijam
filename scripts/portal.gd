extends Area2D



@export var target_portal_path: NodePath

@export var cooldown_time := 0.5



var can_teleport := true



func _on_body_entered(body: Node) -> void:

	if body.name == "player" and can_teleport:

		var target_portal = get_node(target_portal_path)

		if target_portal and target_portal is Area2D:

			can_teleport = false

			target_portal.can_teleport = false



			# Mover al jugador

			body.global_position = target_portal.global_position



			# Esperar tiempo antes de reactivar teleport

			await get_tree().create_timer(cooldown_time).timeout



			can_teleport = true

			target_portal.can_teleport = true
