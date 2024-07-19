class_name Player2D extends Area2D

var collected_shapes := 0
var max_shapes := 2

## -1 is none, 0 = circle, 1 = square, 2 = triangle
var my_shape_one := -1
var my_shape_two := -1

@export var speed: float = 700
var vel := Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("close_game"):
		get_tree().quit()
	
	if Input.is_action_pressed("reset_game"):
		get_tree().reload_current_scene()
	
	if Input.is_action_pressed("shoot") and collected_shapes >= max_shapes:
		shoot_3D_shape()
	

func _physics_process(delta):
	vel = Vector2(0,0)
	
	if Input.is_action_pressed("player_move_left") and Input.is_action_pressed("player_move_right"):
		vel.x = 0
	elif Input.is_action_pressed("player_move_left"):
		vel.x = -speed
	elif Input.is_action_pressed("player_move_right"):
		vel.x = speed
	
	position += vel * delta
	
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 50, viewRect.size.x - 50)
	

func shoot_3D_shape():
	collected_shapes = 0
	my_shape_one = -1
	my_shape_two = -1
