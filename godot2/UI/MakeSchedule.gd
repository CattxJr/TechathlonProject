extends Control

onready var errorMessage = $ErrorMessage

var classes = ["Music", "World Language", "Art", "Computer Ed", "TechEd", "Science", "Social Studies", "PE", "English", "FACS", "Math", "Learning Center"]
#defines the different classes that students may have
var selection_boxes = []
var selection_boxes_data = []
var room_boxes = []
var room_boxes_data = []
var data = []




func _ready(): #separates the boxes where users may enter their classes
	ScheduleData.load_scrolling($Node2D)
	$OptionButtons.add_constant_override("separation",33)
	$optionbuttons.add_constant_override("separation",30)
	$Day.text = "Day " + str(ScheduleData.day)
	# gets room boxes based on index
	for row in $OptionButtons.get_children():
		room_boxes.append(row.get_child(2))
	# gets selection boxes because they're all in one place 
	selection_boxes = $optionbuttons.get_children() 
	for index in range(len(selection_boxes)):
		add_items(selection_boxes[index],index+1)
		selection_boxes[index].enabled_focus_mode = 0



func add_items(selection_box, period): #takes the input data and displays it in its designated box
	selection_box.add_item("Period " + str(period))
	for term in classes:
		selection_box.add_item(term)
	selection_box.add_item("None")

func check_if_valid(): #checks if the selected classes are valid, along with the room numbers. If they are not filled in or invalid, the program will return a message to the user saying so,
	for selection in selection_boxes:
		var selected_class = selection.get_item_text(selection.get_selected_id())
		selection_boxes_data.append(selected_class)
		if selected_class.substr(0,6) == "Period":
			return [false, "*Class for " + selected_class + " not selected"]
	for index in range(len(room_boxes)):
		if !len(room_boxes[index].text) == 4 and selection_boxes_data[index] != "None":
			return [false, "*Room number for Period " + str(index+1) + " not valid"]
		else:
			room_boxes_data.append(room_boxes[index].text)
	return [true, ""]
func _on_Submit_pressed(): #once the user submits the data, the program will return it and proceed to display the main screen (that displays the current class the student has).
	var return_value = check_if_valid()
	if return_value[0]:
		ScheduleData.data[ScheduleData.day] = [selection_boxes_data, room_boxes_data]
		ScheduleData.day += 1
		if ScheduleData.day == 6:
			ScheduleData.save_schedule()
			ScheduleData.day = 1
			ScheduleData.save_scrolling($Node2D)
			get_tree().change_scene_to(load("res://UI/MainScreen.tscn"))
		else:
			ScheduleData.save_scrolling($Node2D)
			get_tree().reload_current_scene()
	else:
		errorMessage.text = return_value[1]



func _on_BackButton_pressed():
	ScheduleData.save_scrolling($Node2D)
	get_tree().change_scene_to(load("res://UI/HomeMenu.tscn"))


func _on_ForwardButton_pressed():
	ScheduleData.save_scrolling($Node2D)
	get_tree().change_scene_to(load("res://UI/ScheduleMenu.tscn"))
