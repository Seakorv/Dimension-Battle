class_name Player3D extends Area3D

signal shape_shot(projectile, location)

@onready var shape_on_player_position = $ShapeOnPlayerPoint
@onready var top_shape_container = $TopShapeContainer

# SFX
@onready var shoot_sfx = $ShootSFX
@onready var collect1_sfx = $collectfirstSFX
@onready var collect2_sfx = $CollectsecondSFX
@onready var shoot1SFX = $ShootSFX2/Shoot
@onready var shoot2SFX = $ShootSFX2/Shoot2
@onready var shoot3SFX = $ShootSFX2/Shoot3
@onready var shoot4SFX = $ShootSFX2/Shoot4

@onready var sphereSFX = $ShapesSFX/SphereSFX
@onready var cubeSFX = $ShapesSFX/CubeSFX
@onready var pyramidSFX = $ShapesSFX/PyramidSFX
@onready var cylinderSFX = $ShapesSFX/CylinderSFX
@onready var coneSFX = $ShapesSFX/ConeSFX
@onready var prismSFX = $ShapesSFX/PrismSFX

var collected_shapes := 0
var max_shapes := 2
var input_disabled = false
var shouts_muted = true

## -1 is none, 0 = circle, 1 = square, 2 = triangle
var my_shape_one := -1
var my_shape_two := -1
@export var shapes_2D_on_player: Array[PackedScene] = []
@export var shapes_3D_on_player: Array[PackedScene] = []
var my_shape_2D = null
var my_shape_3D = null
var current_3D_ID = -1

@export var speed: float = 8.5
@export var projectile_speed: float = 7
var vel := Vector3(0, 0, 0)
var left_disabled = false
var right_disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !input_disabled:
		if Input.is_action_pressed("close_game"):
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		if Input.is_action_pressed("reset_game"):
			get_tree().reload_current_scene()
		if Input.is_action_pressed("shoot") and collected_shapes >= max_shapes:
			shoot_3D_shape()
		if Input.is_action_just_pressed("MuteShouts"):
			if shouts_muted:
				shouts_muted = false
			else:
				shouts_muted = true
	

func _physics_process(delta):
	vel = Vector3.ZERO
	
	if !input_disabled:
		if Input.is_action_pressed("player_move_left") and Input.is_action_pressed("player_move_right"):
			vel.x = 0
		elif Input.is_action_pressed("player_move_left") and !left_disabled:
			vel.x = -speed
		elif Input.is_action_pressed("player_move_right") and !right_disabled:
			vel.x = speed
	
	position += vel * delta
	

func shoot_3D_shape():
	if my_shape_3D != null:
		my_shape_3D.queue_free()
		shape_shot.emit(shapes_3D_on_player[current_3D_ID], shape_on_player_position.global_position)
		choose_shoot_SFX()
	
	collected_shapes = 0
	current_3D_ID = -1
	my_shape_one = -1
	my_shape_two = -1


func _on_area_entered(area):
	if area is Walls:
		if position.x < 0:
			left_disabled = true
		else:
			right_disabled = true


func _on_area_exited(area):
	if area is Walls:
		left_disabled = false
		right_disabled = false
		

func change_my_symbol():
	if collected_shapes == 1:
		my_shape_2D = shapes_2D_on_player[my_shape_one].instantiate()
		my_shape_2D.position = shape_on_player_position.position
		top_shape_container.add_child(my_shape_2D)
		collect1_sfx.play()
	
	elif collected_shapes == max_shapes:
		my_shape_2D.queue_free()
		my_shape_3D = my_3D_symbol().instantiate()
		my_shape_3D.position = shape_on_player_position.position
		top_shape_container.add_child(my_shape_3D)
		collect2_sfx.play()
		


func my_3D_symbol():
	var shape_3D = null
	match my_shape_one:
		0:
			match my_shape_two:
				0:
					shape_3D = shapes_3D_on_player[0]
					current_3D_ID = 0
					play_shout(0)
				1:
					shape_3D = shapes_3D_on_player[3]
					current_3D_ID = 3
					play_shout(3)
				2:
					shape_3D = shapes_3D_on_player[5]
					current_3D_ID = 5
					play_shout(5)
		1:
			match my_shape_two:
				0:
					shape_3D = shapes_3D_on_player[3]
					current_3D_ID = 3
					play_shout(3)
				1:
					shape_3D = shapes_3D_on_player[1]
					current_3D_ID = 1
					play_shout(1)
				2:
					shape_3D = shapes_3D_on_player[4]
					current_3D_ID = 4
					play_shout(4)
		2:
			match my_shape_two:
				0:
					shape_3D = shapes_3D_on_player[5]
					current_3D_ID = 5
					play_shout(5)
				1:
					shape_3D = shapes_3D_on_player[4]
					current_3D_ID = 4
					play_shout(4)
				2:
					shape_3D = shapes_3D_on_player[2]
					current_3D_ID = 2
					play_shout(2)

	return shape_3D


func play_shout(shape: int):
	if !shouts_muted:
		match shape:
			0:
				sphereSFX.play()
			1:
				cubeSFX.play()
			2:
				pyramidSFX.play()
			3:
				cylinderSFX.play()
			4:
				prismSFX.play()
			5:
				coneSFX.play()

func choose_shoot_SFX():
	var chooser = randi() % 4
	match chooser:
		0:
			shoot1SFX.play()
		1:
			shoot2SFX.play()
		2:
			shoot3SFX.play()
		3:
			shoot4SFX.play()
