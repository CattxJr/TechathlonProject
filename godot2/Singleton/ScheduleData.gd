extends Node

var data = {1:[],2:[],3:[],4:[],5:[]}
var day = 1
var scrolling = 0 
var first = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func save_schedule(): #function saves the schedule
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(data))
	save_game.close()
func load_schedule(): #loads the schedule from a local save, if there is no save then it returns empty
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return false
	save_game.open("user://savegame.save", File.READ)
	var node_data = parse_json(save_game.get_line())
	data = node_data
	print(node_data)
	return true
func save_scrolling(scroller):
	if scroller.get_children()[0].position.x <= 0:
		scrolling = scroller.get_children()[0].position.x 
	else:
		first = false
		print("test")
		scrolling = scroller.get_children()[1].position.x 
func load_scrolling(scroller): #background scroll, because its scrolling thru two images, we need to check which image is offscreen to properly set it again	
	if first:
		scroller.get_children()[0].position.x = scrolling 
		scroller.get_children()[1].position.x += scrolling
	else:
		scroller.get_children()[0].position.x = scrolling 
		scroller.get_children()[1].position.x += scrolling
