class_name Player3DShapes extends Area3D

## 3D-shape ID
@export var shape_ID = 0
@export var speed_when_shot = 10
@export var rot_speed: float = 0.01

var is_shot = false
var speed: float = 0
var vel := Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	rotation.y += rot_speed
	
	if is_shot:
		vel.z = -speed
		position += vel * delta


func shoot_me():
	is_shot = true
	speed = speed_when_shot
