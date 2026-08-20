extends Node2D

enum Turno { MANANA, TARDE, NOCHE }

@export var turno_actual: Turno = Turno.MANANA
@export var interacciones_para_cambiar: int = 3  # Interacciones necesarias para cambiar de turno

var interacciones_restantes: int = 3

# Referencias asignadas desde el Inspector
@export var animador_luz: AnimationPlayer
@export var humo_chimenea: GPUParticles2D
@export var luz_ambiental: CanvasModulate

func _ready():
	aplicar_efectos_turno()

func _process(_delta):
	# TEMPORAL: Usamos la tecla "I" para simular una interacción y probar el sistema
	if Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_I):
		# Nota: Para que la tecla I funcione, debes presionarla y soltarla rápidamente
		pass 

func _unhandled_input(event):
	# TEMPORAL: Simulación de interacción con la tecla "I"
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.pressed and event.keycode == KEY_I):
		registrar_interaccion()

func registrar_interaccion():
	interacciones_restantes -= 1
	print("Interacción registrada. Faltan: ", interacciones_restantes)
	
	if interacciones_restantes <= 0:
		cambiar_turno()
		interacciones_restantes = interacciones_para_cambiar

func cambiar_turno():
	var indice_actual = Turno.values().find(turno_actual)
	var siguiente_indice = (indice_actual + 1) % 3
	turno_actual = Turno.values()[siguiente_indice]
	
	aplicar_efectos_turno()
	print("¡TURNO CAMBIADO A: ", Turno.keys()[siguiente_indice], "!")

func aplicar_efectos_turno():
	match turno_actual:
		Turno.MANANA:
			if humo_chimenea: humo_chimenea.emitting = true
			if animador_luz: animador_luz.stop()
			if luz_ambiental: luz_ambiental.color = Color(1.0, 1.0, 1.0)
			
		Turno.TARDE:
			if humo_chimenea: humo_chimenea.emitting = false
			if animador_luz: animador_luz.stop()
			if luz_ambiental: luz_ambiental.color = Color(1.2, 0.9, 0.6)
			
		Turno.NOCHE:
			if humo_chimenea: humo_chimenea.emitting = true
			if animador_luz: animador_luz.play("parpadeo_ventana")
			if luz_ambiental: luz_ambiental.color = Color(0.3, 0.3, 0.5)
