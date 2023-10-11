extends RayCast2D

func _ready():
	pass
	
func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 15.0, 0, 3)
	$Tween.start()
