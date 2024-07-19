extends Resource
class_name HighScoreData

var scores: Array[int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var player_names: Array[String] = ["kissa", "kissa", "kissa", "kissa", "kissa", "kissa", "kissa", "kissa", "kissa", "kissa"]
var scores_max_size = 10

func save_highscores(highscore: int, name: String):
	var is_high_score = false
	var index = 0
	while index < scores.size():
		if scores[index] < highscore:
			change_scores(index, highscore)
			change_score_names(index, name)
			break
		index += 1


func get_high_scores():
	return scores


func get_high_score_names():
	return player_names


func change_scores(index: int, highscore: int):
	var help
	while index < scores.size()-1:
		help = scores[index]
		scores[index] = highscore
		highscore = scores[index + 1]
		scores[index + 1] = help
		index += 2


func change_score_names(index: int, names: String):
	var help
	while index < player_names.size() -1:
		help = player_names[index]
		player_names[index] = names
		names = player_names[index + 1]
		player_names[index + 1] = help
		index += 2
