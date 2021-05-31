extends Control

var times = ["8:30 - 9:27", "9:27 - 10:19", "10:24 - 11:16", "11:21 - 1:11", "1:16 - 2:08", "2:13 - 3:07"] #times for table 
onready var mansalva_font = preload("res://Winchester/font3.tres")
onready var main_screen = null 
func _ready():
	if get_tree().get_current_scene().get_name() == "ScheduleMenuVersion2":
		main_screen = load("res://UI/MainScreen.tscn")
	ScheduleData.load_scrolling($Node2D)
	ScheduleData.load_schedule()
	for index in range(1,6):
		$OptionButton.add_item("Day " + str(index))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func add_times():
	var children = $Times.get_children()
	for index in range(len(children)):
		children[index].add_font_override("font", mansalva_font)
		children[index].add_color_override("font_color", Color.black)
		children[index].text = times[index]

func add_periods(day):
	var children = $Periods.get_children()
	for index in range(len(children)):
		children[index].add_font_override("font", mansalva_font)
		children[index].add_color_override("font_color", Color.black)
		children[index].text = ScheduleData.data[day][0][index]


func _on_Confirm_pressed():
	add_times()
	add_periods(($OptionButton.get_item_text($OptionButton.get_selected_id()))[4])


func _on_Button_pressed():
	ScheduleData.save_scrolling($Node2D)
	get_tree().change_scene_to(main_screen)
