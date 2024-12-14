extends State
class_name FALL
@export var moveSpeed := 340
@export var airControlFactor := 0.5

func enter():
	sprite_2d.play("fall")
	player.velocity.x = player.velocity.x

func update(delta):
	if player.is_on_floor():
		Transitioned.emit(self, "IDLE")

func physics_update(delta):
	var input_direction = Input.get_axis("move_left", "move_right")
	
	# Air control
	if input_direction:
		player.velocity.x = input_direction * (moveSpeed * 20 * airControlFactor * delta)
		
		# Update sprite direction
		sprite_2d.flip_h = input_direction < 0
	else:
		# Gradually reduce horizontal velocity if no input
		player.velocity.x = move_toward(player.velocity.x, 0, moveSpeed * delta)
	
	# Apply gravity
	if !player.is_on_floor():
		if player.velocity.y < maxGravity:
			player.velocity.y += player.get_gravity().y * delta
	
	player.move_and_slide()
