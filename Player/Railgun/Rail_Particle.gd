extends CPUParticles2D

var rail_part_path = preload("res://Player/Railgun/Rail_Charge_Part.tscn")
var glow = Color(2.25, 2, 2.25, 1)
var less_glow = Color(2, 1.75, 2, 1)

func emit_particles(charge):
	# charge
	var rail_part = rail_part_path.instance()
	add_child(rail_part)
	rail_part.start(charge)
	
	self.set("initial_velocity", 225)
	self.set("speed_scale", 1.8)
	self.set("lifetime", charge)
	self.set("modulate", glow)
	yield(get_tree().create_timer(charge), "timeout")
	
	# cool
	self.set("modulate", less_glow)
	self.set("initial_velocity", 75)
	self.set("speed_scale", 1)
	self.set("lifetime", 1)
