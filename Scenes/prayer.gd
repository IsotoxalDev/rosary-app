extends Control

var elem
onready var title  = $Label2
onready var body  = $Label

func _ready():
	elem = Globals.prayer_data.prayers.keys()[Globals.current_namaskaram]
	title.set_text(Globals.prayer_data["prayers"][elem]["Name"])
	body.set_text(Globals.prayer_data["prayers"][elem]["Prayer"][Globals.current_namaskaram_page])

func _on_Previous_pressed():
	if Globals.current_namaskaram_page == 0:
		if Globals.current_namaskaram == 0:
			get_tree().change_scene("res://Scenes/Namaskarangal.tscn")
			return
		else:
			Globals.current_namaskaram -= 1
	else:
		Globals.current_namaskaram_page -= 1
	get_tree().reload_current_scene()

func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Namaskarangal.tscn")

func _on_Next_pressed():
	if Globals.current_namaskaram_page >= len(Globals.prayer_data["prayers"][elem]["Prayer"])-1:
		if Globals.current_namaskaram >= len(Globals.prayer_data["prayers"])-1:
			get_tree().change_scene("res://Scenes/Namaskarangal.tscn")
			return
		else:
			Globals.current_namaskaram += 1
			Globals.current_namaskaram_page = 0
	else:
		Globals.current_namaskaram_page += 1
	get_tree().reload_current_scene()
