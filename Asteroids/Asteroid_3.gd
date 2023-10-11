extends RigidBody2D

signal destroyed

var particles_path = preload("res://Asteroids/Asteroid_3_Part.tscn")

func _ready():
	var angle_dir = rand_range(0, 1)
	if angle_dir < .5: 
		angle_dir = -1
	else:
		angle_dir = 1
	var angle_speed = angle_dir * rand_range(PI * .75, PI)
	var speed = rand_range(200, 600)
	
	global_rotation = rand_range(0, PI * 2)
	angular_velocity = angle_speed
	linear_velocity = Vector2(speed, speed).rotated(global_rotation)
	
func _on_Area2D_area_entered(area):
	destroy()

func destroy():
	Asteroid_3.emit_signal("destroyed")
	
	var part = particles_path.instance()
	part.global_position = global_position
	get_tree().root.add_child(part)
	
	queue_free()
