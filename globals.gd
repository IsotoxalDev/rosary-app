extends Node

const SUNDAY : int = 0
enum prayer_type {
	NORMAL
	HOLY
	RESURRECTION
}
var page : Dictionary = {
	"MENU": {
		"text": "",
		"scene": "res://Scenes/Main.tscn",
		"image": ""
	},
	"SP": {
		"text": "{XnkÔym P]w",
		"scene": "res://Scenes/SandhyaPrarthana.tscn",
		"image": "res://Assets/hands.jpg"
	},
	"MV": {
		"text": "acn¨ hnizmknIÄ¡v thWvSnbpÅ P]w",
		"scene": "res://Scenes/MV.tscn",
		"image": "res://Assets/ressuruction.png"
	},
	"JM": {
		"text": "P]ame",
		"scene": "res://Scenes/Japamala.tscn",
		"image": ""
	}
}
var current_page = page.MENU
var previous_page = page.MENU
var next_page = page.MENU
var prayer
var current_prayer = null
var current = {
	"sp": 0,
	"mv": 0,
	"jm": 0,
	"nkidx": 0,
	"nkpge": 0
}
var easter_date
var current_date
var big_wednesday
var holy_trinity
var current_namaskaram = 0
var current_namaskaram_page = 0
var prayer_data

func _ready():
	current_date = OS.get_unix_time()
	easter_date = _get_easter_date()
	big_wednesday = easter_date-(86400*4)
	holy_trinity = easter_date+(86400*56)
	prayer = str(prayer_type.NORMAL)
	if current_date > big_wednesday and current_date < easter_date:
		prayer = str(prayer_type.HOLY)
	elif current_date >= easter_date and current_date < holy_trinity:
		prayer = str(prayer_type.RESURRECTION)
	var file = File.new()
	file.open("res://Scenes/prayer_data_malayalam.json", File.READ)
	prayer_data = parse_json(file.get_as_text())
	file.close()

func _get_easter_date():
	var date = OS.get_datetime()
	date.month = 3
	date.day = 22
	date.hour = 1
	date = OS.get_unix_time_from_datetime(date)
	var full_moon = false
	while !full_moon:
		full_moon = _is_full_moon(date)
		date += 86400
	while OS.get_datetime_from_unix_time(date).weekday != SUNDAY:
		date += 86400
	return date

func _is_full_moon(ts):
	var day_after_full_moon = ((ts*1000-1817643401)%2551442803)
	day_after_full_moon /= 1000
	day_after_full_moon /= 86400
	return true if day_after_full_moon == 0 else false
