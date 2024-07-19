extends Node

var high_score_data = HighScoreData.new()

var save_file_path = "user://save/"
var save_file_name = "SavedHighScores.tres"


func _ready():
	verify_save_directory(save_file_path)
	load_highscores()


func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)


func save_highscores(highscore: int, name: String):
	high_score_data.save_highscores(highscore, name)
	ResourceSaver.save(high_score_data, save_file_path + save_file_name)


func load_highscores():
	high_score_data = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)


func get_hs():
	return high_score_data.get_high_scores()


func get_hs_names():
	return high_score_data.get_high_score_names()
