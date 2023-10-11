extends RigidBody2D

signal destroyed
signal spawned

var asteroid_4_path = preload("res://Asteroids/Asteroid_4.tscn")
var particles_path = preload("res://Asteroids/Asteroid_5_Part.tscn")

func _ready():
	var angle_dir = rand_range(0, 1)
	if angle_dir < .5: 
		angle_dir = -1
	else:
		angle_dir = 1
	var angle_speed = angle_dir * rand_range(PI * .25, PI * .5)
	var speed = rand_range(50, 400)

	global_rotation = rand_range(0, PI * 2)
	angular_velocity = angle_speed
	linear_velocity = Vector2(speed, speed).rotated(global_rotation)
	
func _on_Area2D_area_entered(area):
	destroy()

func destroy():
	Asteroid_5.emit_signal("destroyed")
	
	var part = particles_path.instance()
	part.global_position = global_position
	get_tree().root.add_child(part)
	
	var num_spawn = rand_range(2, 4)
	yield(get_tree().create_timer(.03), "timeout")
	for i in range(num_spawn):
		spawn_asteroid_4()
		Asteroid_5.emit_signal("spawned")
		
	queue_free()

func spawn_asteroid_4():
	var asteroid_4 = asteroid_4_path.instance()
	asteroid_4.global_position = global_position
	get_tree().root.add_child(asteroid_4)
