extends State
class_name RUN

@export var moveSpeed := 340
var direction

func enter():
	sprite_2d.play("run")

func update(delta):
	if player.is_on_floor():
		if direction != 0:
			if Input.is_action_just_pressed("dash"):
				Transitioned.emit(self, "DASH")
			elif Input.is_action_just_pressed("move_up"):
				Transitioned.emit(self, "JUMP")
	else:
		print("Transitioned to IDLE")
		Transitioned.emit(self, "IDLE")
	

func physics_update(delta):
	direction = Input.get_axis("move_left", "move_right")
	
	if player.is_on_floor():
		if direction:
			player.velocity.x = (direction * moveSpeed * 20) * delta
		else:
			Transitioned.emit(self, "IDLE")
	
	player.move_and_slide()
