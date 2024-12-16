extends State
class_name FALL
@export var moveSpeed := 340
@export var airControlFactor := 0.5
@export var maxSpeed := 500

func enter():
	print("Entered", name)
	sprite_2d.play("fall")
	player.velocity.x = player.velocity.x

func update(delta):
	if Input.is_action_just_pressed("dash"):
		if dash_cooldown.is_stopped():
			Transitioned.emit(self, "DASH")
	if player.is_on_floor():
		Transitioned.emit(self, "IDLE")

func physics_update(delta):
	var input_direction = Input.get_axis("move_left", "move_right")
	
	# Air control
	if input_direction:
		player.velocity.x = move_toward(player.velocity.x, input_direction * moveSpeed * airControlFactor, moveSpeed * delta)
		
		# Update sprite direction
		animate(input_direction)
	else:
		# Gradually reduce horizontal velocity if no input
		player.velocity.x = move_toward(player.velocity.x, 0, moveSpeed * delta)
	
	# Apply gravity
	if !player.is_on_floor():
		if player.velocity.y < maxGravity:
			player.velocity.y += player.get_gravity().y * delta
	
	if player.velocity.x <= -maxSpeed:
		player.velocity.x = -maxSpeed
	elif player.velocity.x >= maxSpeed:
		player.velocity.x = maxSpeed
	
	player.move_and_slide()

func animate(direction):
	if direction < 0:
		sprite_2d.flip_h = true
	elif direction > 0:
		sprite_2d.flip_h = false
	
