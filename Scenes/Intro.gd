extends Control

onready var label = $Label
onready var texture_rect = $TextureRect

func _ready():
	if Globals.current_page == Globals.page.MENU:
		get_tree().change_scene(Globals.page.MENU.scene)
	label.set_text(Globals.current_page.text)
	texture_rect.set_texture(load(Globals.current_page.image))

func _on_Back_pressed():
	get_tree().change_scene(Globals.previous_page.scene)

func _on_Skip_pressed():
	Globals.previous_page = Globals.current_page
	Globals.current_page = Globals.next_page
	if Globals.current_page == Globals.page.MV:
		Globals.next_page = Globals.page.JM
	else:
		Globals.next_page = Globals.page.MENU
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	get_tree().change_scene(Globals.page.MENU.scene)


func _on_Next_pressed():
	get_tree().change_scene(Globals.current_page.scene)
