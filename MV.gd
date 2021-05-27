extends Control

onready var label = $Label
var current = Globals.current.mv

func _ready():
	change_current(0)

func change_current(val):
	current += val
	if current < 0:
		get_tree().change_scene("res://Scenes/Main.tscn")
	elif current >= len(Globals.prayer_data.moksha)-1:
		Globals.previous_page = Globals.current_page
		Globals.current_page = Globals.next_page
		Globals.next_page = Globals.page.MENU
		get_tree().change_scene("res://Scenes/Intro.tscn")
	if Globals.prayer_data.moksha[current] in Globals.prayer_data.common.keys():
			label.set_text(Globals.prayer_data.common[Globals.prayer_data.moksha[current]])
	else:
		label.set_text(Globals.prayer_data.moksha[current])
	Globals.current.mv = current
	

func _on_Next_pressed():
	change_current(1)

func _on_Previous_pressed():
	change_current(-1)

func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
