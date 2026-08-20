extends CharacterBody2D

# Velocidad de movimiento del jugador
@export var velocidad: float = 150.0

# Referencia al sprite animado
@onready var sprite = $SpritePersonaje

# Variable para recordar la última dirección (para el idle)
var ultima_direccion = "abajo"

func _physics_process(delta):
	# 1. Obtener la dirección de entrada (WASD o Flechas)
	var direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Calcular la velocidad
	velocity = direccion * velocidad
	
	# 3. Mover el personaje
	move_and_slide()
	
	# 4. Actualizar animaciones y dirección
	actualizar_animacion(direccion)

func actualizar_animacion(direccion: Vector2):
	# Si el jugador se está moviendo
	if direccion != Vector2.ZERO:
		
		# Determinar hacia dónde mira
		if direccion.y < 0:
			ultima_direccion = "arriba"
			sprite.play("caminar_arriba")
			sprite.flip_h = false
		elif direccion.y > 0:
			ultima_direccion = "abajo"
			sprite.play("caminar_abajo")
			sprite.flip_h = false
		elif direccion.x < 0:
			ultima_direccion = "izquierda"
			sprite.play("caminar_izquierda")
			sprite.flip_h = false
		elif direccion.x > 0:
			ultima_direccion = "derecha"
			sprite.play("caminar_izquierda")
			sprite.flip_h = true
			
	else:
		# Si NO se está moviendo, reproducir el Idle de la última dirección
		match ultima_direccion:
			"arriba":
				sprite.play("idle_arriba")
				sprite.flip_h = false
			"abajo":
				sprite.play("idle_abajo")
				sprite.flip_h = false
			"izquierda":
				sprite.play("idle_izquierda")
				sprite.flip_h = false
			"derecha":
				sprite.play("idle_izquierda")
				sprite.flip_h = true
