extends Control

var tiempo_transcurrido: float = 0.0
var tiempo_total: float = 3.0

func _process(delta: float) -> void:
	tiempo_transcurrido += delta
	var progreso = (tiempo_transcurrido / tiempo_total) * 100
	progreso = min(progreso, 100)
	
	$BarraProgreso.value = progreso
	
	if tiempo_transcurrido >= tiempo_total:
		get_tree().change_scene_to_file("res://escenas/menu_principal.tscn")
