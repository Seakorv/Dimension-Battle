class_name TwoDimShape extends Area2D

signal im_collected(my_shape_ID)

## Shape ID as an int. 0 is circle, 1 is rect and 2 is triangle
@export var my_shape_ID := 0
@export var speed := 400

var vel := Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	vel.y = speed
	position += vel * delta


func _on_area_entered(body):
	if body is Player2D:
		if body.collected_shapes < body.max_shapes:
			im_collected.emit(my_shape_ID)
			queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
