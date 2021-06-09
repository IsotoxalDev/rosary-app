extends Control

enum  mystery_type {
	JOY
	LIGHT
	SORROW
	GLORY
}
var to_draw = {}
var title_idx = 0
var title_txt
var mystery
var blank
onready var title = $Label2
onready var body = $Label
onready var background = $TextureRect

func _ready():
	blank = background.texture
	mystery = _get_mystery_type()
	to_draw["P]ame"] = []
	add(to_draw["P]ame"], "PREJM1")
	to_draw["hnizmk{]amWw"] = []
	add(to_draw["hnizmk{]amWw"], Globals.prayer_data.prayers["BELIEF"].Prayer)
	to_draw[" "] = []
	add(to_draw[" "], Globals.prayer_data.common["PREJM2"])
	match mystery:
		0:
			to_draw[Globals.prayer_data.prayers["JOYMYS"].Name] = []
			for i in range(Globals.prayer_data.Mysteries["JOY"].size()):
				add(to_draw[Globals.prayer_data.prayers["JOYMYS"].Name], [Globals.prayer_data.Mysteries["JOY"][i], pray("@iJOY"+str(i+1))])
		1:
			to_draw[Globals.prayer_data.prayers["LIGHTMYS"].Name] = []
			for i in Globals.prayer_data.Mysteries["LIGHT"].size():
				add(to_draw[Globals.prayer_data.prayers["LIGHTMYS"].Name], [Globals.prayer_data.Mysteries["LIGHT"][i], pray("@iLIG"+str(i+1))])
		2:
			to_draw[Globals.prayer_data.prayers["SORROWMYS"].Name] = []
			for i in Globals.prayer_data.Mysteries["SORROW"].size():
				add(to_draw[Globals.prayer_data.prayers["SORROWMYS"].Name], [Globals.prayer_data.Mysteries["SORROW"][i], pray("@iSOR"+str(i+1))])
		3:
			to_draw[Globals.prayer_data.prayers["GLORYMYS"].Name] = []
			for i in Globals.prayer_data.Mysteries["GLORY"].size():
				add(to_draw[Globals.prayer_data.prayers["GLORYMYS"].Name], [Globals.prayer_data.Mysteries["GLORY"][i], pray("@iGLO"+str(i+1))])
	to_draw["P]ame kaÀ¸Ww"] = []
	add(to_draw["P]ame kaÀ¸Ww"], Globals.prayer_data.prayers["ROSARYEND"].Prayer)
	to_draw["ssZhamXmhnsâ ep¯n\\nb"] = []
	add(to_draw["ssZhamXmhnsâ ep¯n\\nb"], Globals.prayer_data.prayers["LITINY"].Prayer)
	title_txt = to_draw.keys()[title_idx]
	title.set_text(title_txt)
	draw()

func pray(prefix):
	var out = []
#	out.append("OFIH1")
	out.append(prefix + "OFIH2")
	for i in range(10):
		out.append("@c" + str(i) + prefix + "HAIL1")
		out.append(prefix + "HAIL2")
	out.append(prefix + "GLRY1")
	out.append(prefix + "GLRY2")
	out.append(prefix + "OMJ")
	return out

func add(to : Array, val):
	if typeof(val) == typeof([]):
		for i in val:
			add(to, i)
	else:
		to.append(val)

func draw(forward = true):
	if not forward:
		if Globals.current.jm != 0:
			Globals.current.jm -= 1
		else:
			if title_idx != 0:
				title_idx -= 1
				title_txt = to_draw.keys()[title_idx]
				title.set_text(title_txt)
				Globals.current.jm = len(to_draw[title_txt]) -1
			else:
				get_tree().change_scene(Globals.previous_page.scene)
	if Globals.current.jm == len(to_draw[title_txt]):
		title_idx+=1
		if title_idx == len(to_draw):
			get_tree().change_scene("res://Scenes/Main.tscn")
		else:
			title_txt = to_draw.keys()[title_idx]
			title.set_text(title_txt)
			Globals.current.jm = 0
			draw()
	else:
		var text = to_draw[title_txt][Globals.current.jm]
		text = check_prefix(text)
		if text in Globals.prayer_data.common.keys():
			body.set_text(Globals.prayer_data.common[text])
		else:
			body.set_text(text)
		Globals.current.jm += 1

func _get_mystery_type():
	match OS.get_datetime().weekday:
		0:
			var dec1 = OS.get_datetime()
			var lent3 = Globals.easter_date-(67*86400)
			dec1.hour = 1
			dec1.month = 12
			dec1.day = 1
			dec1 = OS.get_unix_time_from_datetime(dec1)
			if OS.get_unix_time() > dec1:
				return mystery_type.JOY
			if OS.get_unix_time() < lent3:
				return mystery_type.JOY
			if OS.get_unix_time() > lent3 and OS.get_unix_time() < Globals.easter_date:
				return mystery_type.SORROW
			return mystery_type.GLORY
		1:
			return mystery_type.JOY
		2:
			return mystery_type.SORROW
		3:
			return mystery_type.GLORY
		4:
			return mystery_type.LIGHT
		5:
			return mystery_type.SORROW
		6:
			return mystery_type.JOY


func _on_Next_pressed():
	draw()


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Previous_pressed():
	Globals.current.jm -= 1
	draw(false)

func check_prefix(text):
	if text[0] == "@":
		match text[1]:
				"i":
					var img_path = Globals.prayer_data.Images[text.substr(2, 4)]
					background.set_texture(load(img_path))
					text = text.substr(6, -1)
					return text
				"c":
					$HBoxContainer2/Label4.set_text("")
					for i in range(int(text[2])+1):
						$HBoxContainer2/Label4.set_text($HBoxContainer2/Label4.get_text() + "0")

					return check_prefix(text.substr(3,-1))
				_:
					$HBoxContainer2/Label4.set_text("")
					background.texture = null
					return text
	else:
		$HBoxContainer2/Label4.set_text("")
		return text
