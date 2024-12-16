extends State
class_name IDLE

@export var friction := 340.0

func enter():
	print("Entered", name)
	sprite_2d.play("idle")

func update(delta):
	if player.is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			Transitioned.emit(self, "RUN")
		elif Input.is_action_just_pressed("move_up"):
			Transitioned.emit(self, "JUMP")
	elif !player.is_on_floor():
		Transitioned.emit(self, "FALL")
	if Input.is_action_just_pressed("dash"):
		if dash_cooldown.is_stopped():
			Transitioned.emit(self, "DASH")

func physics_update(delta):
	player.velocity.x = move_toward(player.velocity.x, 0, abs(player.velocity.x)*8.8 * delta)
	
	player.move_and_slide()
