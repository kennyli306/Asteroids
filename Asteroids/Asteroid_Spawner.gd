extends Node2D

var asteroid_3_path = preload("res://Asteroids/Asteroid_3.tscn")
var asteroid_4_path = preload("res://Asteroids/Asteroid_4.tscn")
var asteroid_5_path = preload("res://Asteroids/Asteroid_5.tscn")

var num_spawn = 0
var max_spawn = 1200
var spawn_range = 1200
var spawn_speed = .5

func _ready():
	Asteroid_5.connect("destroyed", self, "_on_asteroid_destroyed")
	Asteroid_4.connect("destroyed", self, "_on_asteroid_destroyed")
	Asteroid_3.connect("destroyed", self, "_on_asteroid_destroyed")
	
	Asteroid_5.connect("spawned", self, "_on_asteroid_spawned")
	Asteroid_4.connect("spawned", self, "_on_asteroid_spawned")
	
	for i in range(max_spawn):
		var vec = rand_Vector2()
		var pos = get_parent().global_position
		global_position = pos + vec
		spawn()
		num_spawn += 1
		yield(get_tree().create_timer(spawn_speed), "timeout")

func _on_asteroid_destroyed():
	num_spawn -= 1;
	
func _on_asteroid_spawned():
	num_spawn += 1;

func rand_Vector2() -> Vector2:
	var x = rand_range(0, 1)
	if (x < .5):
		x = 1
	else:
		x = -1
	
	var y = rand_range(0, 1)
	if (y < .5):
		y = 1
	else:
		y = -1
	
	var vec = Vector2(x * spawn_range, y * spawn_range)
	return vec

func spawn():
	var chance = rand_range(0, 10)
	if (chance < 2):
		spawn_asteroid_5()
	elif (chance < 5):
		spawn_asteroid_4()
	else:
		spawn_asteroid_3()

func spawn_asteroid_3():
	var asteroid_3 = asteroid_3_path.instance()
	asteroid_3.global_position = global_position
	get_tree().root.add_child(asteroid_3)

func spawn_asteroid_4():
	var asteroid_4 = asteroid_4_path.instance()
	asteroid_4.global_position = global_position
	get_tree().root.add_child(asteroid_4)

func spawn_asteroid_5():
	var asteroid_5 = asteroid_5_path.instance()
	asteroid_5.global_position = global_position
	get_tree().root.add_child(asteroid_5)
