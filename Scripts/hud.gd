class_name HUD extends Control

@export var score_label : Label
@export var lives_label : Label


func update_score(score : int):
	score_label.text = "Pisteet : " + str(score)


func update_lives(lives : int):
	lives_label.text = str(lives)
