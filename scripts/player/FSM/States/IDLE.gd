extends State
class_name IDLE

@export var friction := 340.0

func enter():
	sprite_2d.play("idle")

func update(delta):
	if player.is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			Transitioned.emit(self, "RUN")
			print("Transitioned to RUN")
	elif !player.is_on_floor():
		Transitioned.emit(self, "FALL")

func physics_update(delta):
	player.velocity.x = move_toward(player.velocity.x, 0, friction * delta)
	
	player.move_and_slide()
