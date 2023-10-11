extends CPUParticles2D

var on = false

func _process(_delta):
	if (Input.is_action_pressed("down") || Input.is_action_pressed("right") || on):
		self.set("initial_velocity", 100)
	else:
		self.set("initial_velocity", 0)

func on():
	on = true
func off():
	on = false
