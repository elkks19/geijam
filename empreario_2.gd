extends CharacterBody2D

# Configuración de movimiento
const MAX_SPEED = 300.0
const ACCELERATION = 1500.0
const FRICTION = 2000.0
const AIR_RESISTANCE = 500.0
const JUMP_VELOCITY = -400.0
const DOUBLE_JUMP_VELOCITY = -300.0
const WALL_JUMP_PUSH = 200.0
const COYOTE_TIME = 0.1
const JUMP_BUFFER = 0.1

# Variables de estado
var has_double_jump := false
var coyote_time_counter := 0.0
var jump_buffer_counter := 0.0
var is_wall_sliding := false
var last_wall_normal := Vector2.ZERO

# Obtener gravedad del proyecto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_jump_mechanics(delta)
	handle_movement(delta)
	
	move_and_slide()
	update_animation()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		# Wall sliding gravity
		if is_wall_sliding and velocity.y > 0:
			velocity.y = min(velocity.y, gravity * delta * 0.5)

func handle_jump_mechanics(delta: float) -> void:
	# Coyote time
	if is_on_floor():
		coyote_time_counter = COYOTE_TIME
		has_double_jump = true
	else:
		coyote_time_counter -= delta
	
	# Jump buffer
	if Input.is_action_just_pressed("empresario_jump"):
		jump_buffer_counter = JUMP_BUFFER
	else:
		jump_buffer_counter -= delta
	
	# Saltos
	if jump_buffer_counter > 0:
		if coyote_time_counter > 0: # Salto normal
			velocity.y = JUMP_VELOCITY
			jump_buffer_counter = 0
			coyote_time_counter = 0
		elif is_on_wall_only(): # Wall jump
			velocity.y = JUMP_VELOCITY * 0.8
			velocity.x = last_wall_normal.x * WALL_JUMP_PUSH
			jump_buffer_counter = 0
		elif has_double_jump: # Double jump
			velocity.y = DOUBLE_JUMP_VELOCITY
			has_double_jump = false
			jump_buffer_counter = 0

func handle_movement(delta: float) -> void:
	var direction = Input.get_axis("empresario_left", "empresario_right")
	
	if direction != 0:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
		else:
			velocity.x = move_toward(velocity.x, direction * MAX_SPEED, (ACCELERATION * 0.6) * delta)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, AIR_RESISTANCE * delta)


func update_animation() -> void:
	# Aquí puedes agregar lógica para cambiar animaciones según el estado
	if is_on_floor():
		if abs(velocity.x) > 10:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = velocity.x < 0
		else:
			$AnimatedSprite2D.play("idle")
	else:
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("fall")
	
	if is_wall_sliding:
		$AnimatedSprite2D.play("wall_slide")
		$AnimatedSprite2D.flip_h = last_wall_normal.x > 0

func die():
	get_tree().call_deferred("reload_current_scene")
