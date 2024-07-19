extends Node

@onready var bg1 = $BGMusicOne
@onready var bg2 = $BGMusicTwo
@onready var bg_intro = $BGIntro

func change_music(is_low_life):
	bg_intro.playing = false
	if is_low_life:
		bg1.playing = false
		bg2.playing = true
	else:
		bg1.playing = true
		bg2.playing = false


func play_intro():
	bg1.playing = false
	bg2.playing = false
	bg_intro.playing = true
