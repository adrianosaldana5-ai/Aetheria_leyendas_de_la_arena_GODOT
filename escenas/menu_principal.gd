extends Control

func _ready() -> void:
	$BotonNuevaPartida.pressed.connect(_al_nueva_partida)
	$BotonContinuar.pressed.connect(_al_continuar)
	$BotonOpciones.pressed.connect(_al_opciones)

func _al_nueva_partida() -> void:
	get_tree().change_scene_to_file("res://escenas/creador_personaje.tscn")

func _al_continuar() -> void:
	if Global.existe_partida_guardada:
		get_tree().change_scene_to_file("res://escenas/hub_pueblo.tscn")

func _al_opciones() -> void:
	get_tree().change_scene_to_file("res://escenas/menu_opciones.tscn")
