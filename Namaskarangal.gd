extends Control

var is_last : bool
onready var container = $Container
onready var namaskarangalscn = preload("res://Scenes/Namaskaram.tscn")

func _ready():
	is_last = false
	draw()
	pass

func draw():
	for j in container.get_children():
		j.queue_free()
	for i in range(12):
		var idx = Globals.current.nkidx * 12 + i
		if idx < Globals.prayer_data.prayers.size():
			#print("idx: ", idx, "size:", len(Globals.prayer_data.prayers))
			var new_namaskaram = namaskarangalscn.instance()
			new_namaskaram.init(Globals.prayer_data.prayers.keys()[idx],
			Globals.prayer_data.prayers[Globals.prayer_data.prayers.keys()[idx]].Name)
			new_namaskaram.connect("namaskaram_pressed", self, "namaskaram_pressed")
			container.add_child(new_namaskaram)
		else:
			is_last = true


func _on_Previous_pressed():
	if Globals.current.nkidx == 0:
		get_tree().change_scene("res://Scenes/Main.tscn")
	else:
		Globals.current.nkidx -= 1
		get_tree().reload_current_scene()

func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_Next_pressed():
	if is_last: 
		get_tree().change_scene("res://Scenes/Main.tscn")
	else:
		Globals.current.nkidx += 1
		get_tree().reload_current_scene()

func namaskaram_pressed():
	Globals.current_namaskaram_page = 0
	get_tree().change_scene("res://Scenes/prayer.tscn")
	pass
