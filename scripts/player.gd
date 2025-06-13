extends CharacterBody2D

const SPEED = 150
const JUMP_FORCE = -1000
const GRAVITY = 800

func _physics_process(delta):
	# Aplicar gravedad si no está en el suelo
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		# Salto si está en el suelo
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_FORCE

	# Movimiento horizontal (solo izquierda/derecha)
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * SPEED

	# Aplicar movimiento
	move_and_slide()

func die():
	get_tree().call_deferred("reload_current_scene")
