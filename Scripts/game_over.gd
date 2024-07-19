extends Control

@onready var line_edit = $VBoxContainer/LineEdit

var im_active = false

@export var high_score: Label
var my_score: int
var my_name

func _ready():
	pass


func update_high_score(score):
	high_score.text = "Pisteesi: " + str(score)
	my_score = score


func _process(delta):
	if Input.is_action_pressed("SaveScore") and im_active:
		GlobalScript.save_highscores(my_score, line_edit.text)
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
