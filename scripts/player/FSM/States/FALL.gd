extends State
class_name FALL

@export var maxGravity := 3000

func enter():
	sprite_2d.play("fall")

func update(delta):
	if player.is_on_floor():
		Transitioned.emit(self, "IDLE")

func physics_update(delta):
	if !player.is_on_floor():
		if player.velocity.y < maxGravity:	
			player.velocity.y += player.get_gravity().y * delta
	player.move_and_slide()
