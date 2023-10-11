extends RigidBody2D

var max_speed = 1750
var small_acc = 8
var rotation_speed = 4
var acceleration = 20

# Railgun
var rail_path = preload("res://Player/Railgun/Rail_Beam.tscn")
var rail_rate = 1.4
var rail_charge = rail_rate / 2.0 - .2
var rail_fire = true

func railgun_fire():
	# charge
	$Railgun_Pos/Rail_Particle.emit_particles(rail_charge)
	yield(get_tree().create_timer(rail_charge), "timeout")
	
	# fire
	var rail = rail_path.instance()
	rail.global_position = $Railgun_Pos.global_position
	rail.rotation = self.rotation
	get_tree().root.add_child(rail)
	get_tree().root.move_child(rail, 0)
	yield(get_tree().create_timer(rail_rate), "timeout")

func _process(_delta):
	var edge = Vector2(100000, 100000)
	if (global_position.abs() >= edge):
		global_position = Vector2(0, 0)
	
	if (Input.is_mouse_button_pressed(BUTTON_LEFT) && rail_fire):
		railgun_fire()
		rail_fire = false
		yield(get_tree().create_timer(rail_rate), "timeout")
		rail_fire = true

func _physics_process(delta):
	var v = get_global_mouse_position() - position
	var angle = v.angle()
	var r = global_rotation
	
	var angle_delta = rotation_speed * delta
	angle = lerp_angle(r, angle, 1.0)
	angle = clamp(angle, r - angle_delta, r + angle_delta)
	
	if (linear_velocity.length() >= max_speed):
		linear_damp = acceleration / 2;
	else:
		linear_damp = 0;
	
	if (Input.is_mouse_button_pressed(BUTTON_RIGHT)):
		set_Mini_Thrusters(angle)
		global_rotation = angle
	else:
		$Mini_Thrust_1.off()
		$Mini_Thrust_2.off()
		$Mini_Thrust_3.off()
		$Mini_Thrust_4.off()
		
	if (Input.is_action_pressed("stop") && linear_velocity.length() <= 750):
		linear_damp = .8
	if (Input.is_action_pressed("increase_thrust")):
		apply_impulse(Vector2(0, 0), Vector2(acceleration, 0).rotated(rotation))

	if (Input.is_action_pressed("up")):
		apply_impulse(Vector2(0, 0), Vector2(small_acc, 0).rotated(rotation))
	if (Input.is_action_pressed("down")):
		apply_impulse(Vector2(0, 0), Vector2(small_acc * -1, 0).rotated(rotation))
	if (Input.is_action_pressed("left")):
		apply_impulse(Vector2(0, 0), Vector2(0, small_acc * -1).rotated(rotation))
	if (Input.is_action_pressed("right")):
		apply_impulse(Vector2(0, 0), Vector2(0, small_acc).rotated(rotation))

func set_Mini_Thrusters(angle):
	if (global_rotation - angle < -.03):
		$Mini_Thrust_1.on()
		$Mini_Thrust_4.on()
	else:
		$Mini_Thrust_1.off()
		$Mini_Thrust_4.off()
	if (global_rotation - angle > .03):
		$Mini_Thrust_2.on()
		$Mini_Thrust_3.on()
	else:
		$Mini_Thrust_2.off()
		$Mini_Thrust_3.off()
