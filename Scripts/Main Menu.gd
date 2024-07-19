extends Control

#var global_script = GlobalScript

@onready var hs1 = $Scores/VBoxContainer/Label
@onready var hs2 = $Scores/VBoxContainer/Label2
@onready var hs3 = $Scores/VBoxContainer/Label3
@onready var hs4 = $Scores/VBoxContainer/Label4
@onready var hs5 = $Scores/VBoxContainer/Label5
@onready var hs6 = $Scores/VBoxContainer/Label6
@onready var hs7 = $Scores/VBoxContainer/Label7
@onready var hs8 = $Scores/VBoxContainer/Label8
@onready var hs9 = $Scores/VBoxContainer/Label9
@onready var hs10 = $Scores/VBoxContainer/Label10

var scores: Array[int] = []
var score_names: Array[String] = []
var label_list: Array[Label] = []
var scores_max_size = 10

func _ready():
	BgMusic.play_intro()
	label_list = [hs1, hs2, hs3, hs4, hs5, hs6, hs7, hs8, hs9, hs10]
	load_high_scores()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/3d_game.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_score_board_pressed():
	pass # Replace with function body.


func load_high_scores():
	#GlobalScript.load_highscores()
	scores = GlobalScript.get_hs()
	score_names = GlobalScript.get_hs_names()

	for i in scores.size():
		#print(str(i + 1) + ": " + score_names[i] + " " + str(scores[i]))
		label_list[i].text = str(i + 1) + ": " + score_names[i] + " " + str(scores[i])
