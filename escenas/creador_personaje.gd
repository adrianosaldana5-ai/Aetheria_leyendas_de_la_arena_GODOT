extends Node2D

# Referencias exactas a la jerarquía de tu escena
@onready var vista_previa_pelo: TextureRect = $VistaPrevia/VistaPreviaPelo
@onready var campo_nombre: LineEdit = $ControlesUI/ContenedorNombre/CampoNombre
@onready var boton_comenzar: Node = $ControlesUI/BotonComenzar

# Botones del selector de pelo
@onready var flecha_pelo_menos: Node = $ControlesUI/SelectorColorPelo/FlechaColorPeloMenos
@onready var flecha_pelo_mas: Node = $ControlesUI/SelectorColorPelo/FlechaColorPeloMas

# Lista de texturas
@export_group("Variantes de Pelo")
@export var variantes_color_pelo: Array[Texture2D] = [
	preload("res://assets/imagenes/personaje/personaje_pelo_0.png"),
	preload("res://assets/imagenes/personaje/personaje_pelo_1.png"),
	preload("res://assets/imagenes/personaje/personaje_pelo_2.png")
]

func _ready() -> void:
	# Conectamos los clics a las funciones correspondientes
	flecha_pelo_menos.pressed.connect(_on_flecha_color_pelo_menos_pressed)
	flecha_pelo_mas.pressed.connect(_on_flecha_color_pelo_mas_pressed)
	boton_comenzar.pressed.connect(_on_boton_comenzar_pressed)
	
	actualizar_vista_previa()

func actualizar_vista_previa() -> void:
	if Global.color_pelo >= 0 and Global.color_pelo < variantes_color_pelo.size():
		vista_previa_pelo.texture = variantes_color_pelo[Global.color_pelo]

func _on_flecha_color_pelo_menos_pressed() -> void:
	if variantes_color_pelo.is_empty(): return
	Global.color_pelo = posmod(Global.color_pelo - 1, variantes_color_pelo.size())
	actualizar_vista_previa()

func _on_flecha_color_pelo_mas_pressed() -> void:
	if variantes_color_pelo.is_empty(): return
	Global.color_pelo = posmod(Global.color_pelo + 1, variantes_color_pelo.size())
	actualizar_vista_previa()

func _on_boton_comenzar_pressed() -> void:
	var texto_nombre: String = campo_nombre.text.strip_edges()
	Global.nombre_jugador = texto_nombre if not texto_nombre.is_empty() else "Guerrero"
	get_tree().change_scene_to_file("res://escenas/hub_pueblo.tscn")	
