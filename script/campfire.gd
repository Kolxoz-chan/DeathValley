extends Area2D

var life = 3.0

func addFuel(count):
	life += count

func _on_Timer_timeout():
	if life <= 0:
		$flame.emitting = false
		$light.visible = false
	else:
		life -= 0.05
		$light.texture_scale = life
		print(life)
