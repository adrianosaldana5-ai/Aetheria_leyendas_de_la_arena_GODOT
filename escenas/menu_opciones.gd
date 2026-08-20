extends Control

func _ready() -> void:
	# Configurar valores iniciales desde Global
	$SliderMusica.value = Global.volumen_musica
	$SliderEfectos.value = Global.volumen_efectos
	$BotonPantallaCompleta.button_pressed = Global.pantalla_completa
	
	$BotonIdioma.add_item("Español")
	$BotonIdioma.add_item("English")
	$BotonIdioma.select(0 if Global.idioma == "es" else 1)
	
	_actualizar_textos()
	
	# Conectar señales
	$SliderMusica.value_changed.connect(_al_cambiar_musica)
	$SliderEfectos.value_changed.connect(_al_cambiar_efectos)
	$BotonPantallaCompleta.toggled.connect(_al_cambiar_pantalla)
	$BotonIdioma.item_selected.connect(_al_cambiar_idioma)
	$BotonVolver.pressed.connect(_al_volver)

func _actualizar_textos() -> void:
	$ValorMusica.text = str(round(Global.volumen_musica * 100)) + "%"
	$ValorEfectos.text = str(round(Global.volumen_efectos * 100)) + "%"

func _al_cambiar_musica(nuevo_valor: float) -> void:
	Global.volumen_musica = nuevo_valor
	_actualizar_textos()

func _al_cambiar_efectos(nuevo_valor: float) -> void:
	Global.volumen_efectos = nuevo_valor
	_actualizar_textos()

func _al_cambiar_pantalla(activado: bool) -> void:
	Global.pantalla_completa = activado
	if activado:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _al_cambiar_idioma(indice: int) -> void:
	Global.idioma = "es" if indice == 0 else "en"

func _al_volver() -> void:
	get_tree().change_scene_to_file("res://escenas/menu_principal.tscn")
