extends Control

var date_and_time = null
# in minutes total ex. 8 hours * 60 minutes + 30 minutes
var period_times = [[510,562], [567, 619], [624, 676], [681, 791], [796, 848], [853, 907]]
var test_cases = {"day":29, "dst":false, "hour": 9, "minute":23, "month": 5, "second": 38, "weekday": 4, "year":2021}
var lunchtimes = {"Music":[681,711], "World Language":[681,711], "Art":[681,711], "Computer Ed":[681,711], "TechEd":[681,711], "Science":[721,751], "Social Studies":[721,751], 
"PE":[761,791], "English":[761,791], "FACS":[761,791], "Math":[761,791], "Learning Center":[761,791]}

onready var event = $CurrentClass/Event
onready var event2 = $CurrentClass/Event2
onready var event3 = $CurrentClass/Event3
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#test variables for the date and time with classes for the app

# Called when the node enters the scene tree for the first time.
func _ready():
	ScheduleData.load_scrolling($Node2D)
	ScheduleData.load_schedule()
	$CurrentClass.add_constant_override("separation", 20)
	$NextClass.add_constant_override("separation",20)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed(): #this function will display the class student currently has, however, if the student has no classes, it will display free block, if the day is not monday - friday, it will display free block, and if it is 4th period, it will remind the student to go to lunch
	date_and_time = OS.get_datetime()
	#date_and_time = test_cases
	var total_minutes = (date_and_time["hour"] * 60) + date_and_time["minute"]
	var period = find_period(total_minutes)
	if period != 0 and date_and_time["weekday"] != 6 and date_and_time["weekday"] != 0:
		# +1 for weekday here because date_and_time dictionary only goes up to 6 this was a mistake 1,2,3,4,5 are still the same 
		var lecture = ScheduleData.data[str(date_and_time["weekday"])][0][period-1]
		var room = ScheduleData.data[str(date_and_time["weekday"])][1][period-1]
		if lecture == "None":
			event.text = "Free Block"
			event3.text = str(period_times[period-1][1] - total_minutes) + " minutes left"
		elif period == 4:
			if total_minutes >= lunchtimes[lecture][0] and total_minutes <= lunchtimes[lecture][1]:
				event.text = "Lunch"
				event2.text = str(lunchtimes[lecture][1] - total_minutes) + " minutes left"
			else:
				event.text = lecture
				event2.text = room
				event3.text = str(period_times[period-1][1] - total_minutes) + " minutes left"
		else:
			event.text = lecture
			event2.text = room
			event3.text = str(period_times[period-1][1] - total_minutes) + " minutes left"
		if period != 6:
			var next_lecture = ScheduleData.data[str(date_and_time["weekday"])][0][period]
			var next_room = ScheduleData.data[str(date_and_time["weekday"])][1][period]
			$NextClass/Event4.text = next_lecture 
			$NextClass/Event5.text = next_room 
		else:
			pass
	else:
		if date_and_time["weekday"] == 6 or date_and_time["weekday"] == 0:
			event.text = "Weekend"
		elif total_minutes >= 510 and total_minutes <= 907:
			event.text = "Passing Period"
			var next_period = find_period(total_minutes+5)
			$NextClass/Event4.text = ScheduleData.data[str(date_and_time["weekday"])][0][next_period]
			$NextClass/Event5.text = ScheduleData.data[str(date_and_time["weekday"])][1][next_period]
			event2.text = str(period_times[next_period-1][0] - total_minutes) + " minutes left"
		else:
			event.text = "Not School"

func find_period(time):
	print(time)
	for index in range(len(period_times)):
		#checks if the current time is during a period
		if time >= period_times[index][0] and time <= period_times[index][1]:
			return index+1
	return 0 


func _on_BackButton_pressed():
	ScheduleData.save_scrolling($Node2D)
	get_tree().change_scene_to(load("res://UI/HomeMenu.tscn"))


func _on_ForwardButton_pressed():
	ScheduleData.save_scrolling($Node2D)
	get_tree().change_scene_to(load("res://UI/ScheduleMenuVersion2.tscn"))
