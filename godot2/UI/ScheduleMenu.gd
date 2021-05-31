extends Control

onready var gridContainer = $GridContainer
onready var mansalva_font = preload("res://Winchester/font2.tres")
var times = ["8:30 - 9:27", "9:27 - 10:19", "10:24 - 11:16", "11:21 - 1:11", "1:16 - 2:08", "2:13 - 3:07"] #defines the time stamps for each class/period

func _ready():
	ScheduleData.load_scrolling($Node2D)
	#basic idea is that this will process your schedule and show it visually on a grid 
	#gets all vboxes
	ScheduleData.load_schedule() #loads the schedule in a an indexed and spaced table 
	var vboxes = gridContainer.get_children()
	var vbox = vboxes[0].get_children()
	vboxes[0].add_constant_override("separation",30)
	for index in range(1, len(vbox)):
		vbox[index].text = times[index-1]
		vbox[index].add_font_override("font", mansalva_font)
		vbox[index].add_color_override("font_color", Color.black)
	for index in range(1,len(vboxes)):
		var periods = vboxes[index].get_children()
		periods[0].text = "Day " + str(index)
		periods[0].add_font_override("font", mansalva_font)
		periods[0].add_color_override("font_color", Color.black)
		vboxes[index].add_constant_override("separation", 30) 
		for index2 in range(1,len(periods)):
			#adds period names 
			periods[index2].text = ScheduleData.data[str(index)][0][index2-1]
			periods[index2].add_font_override("font", mansalva_font)
			periods[index2].add_color_override("font_color", Color.black)




func _on_BackButton_pressed():
	ScheduleData.save_scrolling($Node2D)
	get_tree().change_scene_to(main_screen)
