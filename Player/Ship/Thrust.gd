extends CPUParticles2D

func _process(_delta):
	if (Input.is_action_pressed("increase_thrust")):
		if (self.amount != 200):
			self.set("amount", 200)
		
		self.set("speed_scale", 6)
		self.set("initial_velocity", 70)
	else:
		if (self.amount != 50):
			self.set("amount", 50)

			self.set("speed_scale", 4)
			self.set("initial_velocity", 60)
			yield(get_tree().create_timer(.2), "timeout")
			
			self.set("speed_scale", 2)
			self.set("initial_velocity", 40)
			yield(get_tree().create_timer(.4), "timeout")
			
			self.set("speed_scale", 1)
			self.set("initial_velocity", 30)
