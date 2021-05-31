extends Control

#button nodes
onready var makeSchedule = $MakeSchedule
onready var loadSchedule = $LoadSchedule
#defines the user actions


func _ready():
	ScheduleData.load_scrolling($Node2D)
	$ColorRect/Label.text = "Design: Yueran Jia, Leo Qian, Heneni Dong;\nProgramming: Jason Song"


func _on_MakeSchedule_pressed():
	#when you press make schedule, background scrolling is logged and scene is changed
	ScheduleData.save_scrolling($Node2D)
	get_tree().change_scene_to(load("res://UI/MakeSchedule.tscn"))


func _on_LoadSchedule_pressed(): #brings user to the main menu screen once the data is loaded
	if ScheduleData.load_schedule():
		ScheduleData.save_scrolling($Node2D)
		get_tree().change_scene_to(load("res://UI/MainScreen.tscn"))
	else:
		$Warning.text = "*No save file detected!"
