extends Node3D

@onready var shapes_2D_container = $Shapes2DContainer
@onready var timer_2D = $Timer2D
@onready var spawn_2D = $Spawn2DPath/Spawn2DLocation
@onready var projectile_container = $ProjectileContainer
@onready var enemy_container = $EnemyContainer
@onready var enemy_spawn = $SpawnPathEnemies/SpawnLocationEnemies
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var hud = $CanvasLayer/HUD
@onready var game_over = $CanvasLayer/GameOver

# SFX
@onready var hitsfx1 = $SFX/hitsfx
@onready var hitsfx2 = $SFX/hitsfx2
@onready var hitsfx3 = $SFX/hitsfx3
@onready var hitsfx4 = $SFX/hitsfx4
@onready var hitsfx5 = $SFX/hitsfx5
@onready var hitsfx6 = $SFX/hitsfx6
@onready var hitsfx7 = $SFX/hitsfx7
@onready var hitsfx8 = $SFX/hitsfx8
@onready var hitsfx9 = $SFX/hitsfx9
@onready var failSFX = $SFX/FailSFX
@onready var life_lostSFX = $SFX/LifeLostSFX

var music_changed = false

@export var shapes_2D_scenes: Array[PackedScene] = []
@export var enemies: Array[PackedScene] = []

var player = null
var score = 0
@export var lives: int = 3
@export var max_streak: int = 10
var streak: int = 1
@export var one_point: int = 10

# Timer things
var enemy_spawn_skipper = 0 # Enemy will be spawn on true
var enemy
var which_enemy_shape: int
var shape2D_timer_spacer: int = 0
@export var enemy_timer_wait_time: float
@export var timer_fastener: float = 0.05
@export var speed_multiplier_with_time: float = 1.05
var speed_multipiler = 1
var shape2D_timer_wait_time: float
var shape2D_timer_started = false
var hit_counter: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player3D")
	assert(player != null)
	player.shape_shot.connect(_on_shape_shot)
	enemy_spawn_timer.wait_time = enemy_timer_wait_time
	shape2D_timer_wait_time = (2 * enemy_timer_wait_time) / 3.0
	timer_2D.wait_time = shape2D_timer_wait_time
	hud.update_lives(lives)
	hud.update_score(score)
	music_changed = false
	BgMusic.change_music(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Pause"):
		get_tree().paused = true


func spawn_2DShapes():
	var which_shape: int
	
	if shape2D_timer_spacer == 0:
		which_shape = enemy.my_2D_one
		pass
	
	if shape2D_timer_spacer == 1:
		which_shape = enemy.my_2D_two
		pass
	
	if shape2D_timer_spacer == 2:
		shape2D_timer_spacer = -1
		which_shape = randi() % 3
		pass
	
	var shape_2D = shapes_2D_scenes[which_shape].instantiate()
	shape_2D.im_collected.connect(_on_collect_2D_shape)
	
	# Spawn positions of 2D shapes
	spawn_2D.progress_ratio = randf()
	shape_2D.position = spawn_2D.global_position
	shape_2D.speed *= speed_multipiler
	
	shapes_2D_container.add_child(shape_2D)
	
	shape2D_timer_spacer += 1
	

func _on_collect_2D_shape(two_d_shape_ID):
	if player.collected_shapes >= player.max_shapes:
		return
		
	player.collected_shapes += 1
	if player.collected_shapes < player.max_shapes:
		player.my_shape_one = two_d_shape_ID
		player.change_my_symbol()
	else:
		player.my_shape_two = two_d_shape_ID
		player.change_my_symbol()


func _on_timer_2d_timeout():
	spawn_2DShapes()


func _on_shape_shot(shape, location):
	var shot_shape = shape.instantiate()
	projectile_container.add_child(shot_shape)
	shot_shape.global_position = location
	shot_shape.shoot_me()


func spawn_enemies():	
	if enemy_spawn_skipper == 0:
		which_enemy_shape = randi() % 6
		enemy = enemies[which_enemy_shape].instantiate()
	
	if enemy_spawn_skipper == 1:
		enemy.enemy_shot.connect(_on_enemy_shot)
		enemy_container.add_child(enemy)
		enemy_spawn.progress_ratio = randf()
		enemy.position = enemy_spawn.global_position
		enemy.speed *= speed_multipiler
		enemy_spawn_skipper = -1
	
	enemy_spawn_skipper += 1


func _on_enemy_shot(is_correct):
	if is_correct:
		hit_counter += 1
		score += one_point * streak
		play_streak_sound(streak)
		hud.update_score(score)
		if streak < max_streak:
			streak += 1
	
	else:
		streak = 1
		failSFX.play()
	
	if hit_counter % 3 == 0:
		enemy_spawn_timer.wait_time -= timer_fastener
		timer_2D.wait_time = (2 * enemy_spawn_timer.wait_time) / 3
		speed_multipiler *= speed_multiplier_with_time


func _on_enemy_spawn_timer_timeout():
	if !shape2D_timer_started:
		timer_2D.start()
		shape2D_timer_started = true
	spawn_enemies()


func update_lives():
	if lives > 0:
		lives -= 1
		life_lostSFX.play()
	hud.update_lives(lives)
	
	if lives == 1:
		BgMusic.change_music(true)
	
	if lives <= 0:
		if !music_changed:
			BgMusic.change_music(false)
			music_changed = true
		player.input_disabled = true
		game_over.im_active = true
		game_over.update_high_score(score)
		game_over.show()
		#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func play_streak_sound(streak: int):
	match streak:
		1:
			hitsfx1.play()
		2:
			hitsfx2.play()
		3:
			hitsfx3.play()
		4:
			hitsfx4.play()
		5:
			hitsfx5.play()
		6:
			hitsfx6.play()
		7:
			hitsfx7.play()
		8:
			hitsfx8.play()
		9:
			hitsfx9.play()
		10:
			hitsfx9.play()
			hitsfx3.play()
			hitsfx5.play()
