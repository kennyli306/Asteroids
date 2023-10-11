extends CPUParticles2D

func start(charge):
	self.set("emitting", true)
	self.set("speed_scale", 1 / charge)
	self.set("life_time", charge / 2)
	yield(get_tree().create_timer(charge), "timeout")
	
	$Rail_Fire.rotation = self.rotation
	$Rail_Fire.set("emitting", true)
