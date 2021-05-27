extends Control

func _ready():
	for i in Globals.current.keys():
		Globals.current[i] = 0

func _on_prarthana_pressed():
	Globals.current_page = Globals.page.SP
	Globals.next_page = Globals.page.MV
	Globals.previous_page = Globals.page.MENU
	get_tree().change_scene("res://Scenes/Intro.tscn")


func _on_japamala_pressed():
	get_tree().change_scene("res://Scenes/Japamala.tscn")


func _on_Namaskaram_pressed():
	get_tree().change_scene("res://Scenes/Namaskarangal.tscn")
