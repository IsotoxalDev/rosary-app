extends Button

var shortname
signal namaskaram_pressed

func init(shortname, name):
	set_text(name)
	self.shortname = shortname
	pass

func _on_Namaskaram_pressed():
	Globals.current_namaskaram = Globals.prayer_data.prayers.keys().find(shortname)
	emit_signal("namaskaram_pressed")
