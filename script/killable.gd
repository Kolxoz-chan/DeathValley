extends Area2D

var hp = 3

func addHit(power):
	hp -= power
	if hp <= 0:
		queue_free()
		return true
	
	return false
