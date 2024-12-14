extends State
class_name DASH

@export var dashSpeed := 400.0
@export var dashDuration := 0.2
@export var dashCooldown := 1.2

var direction = 0
var dashDurTimer = Timer.new()

signal dashStarted

var calculate_fps = func():
	return (1/dashDuration)*(sprite_2d.sprite_frames.get_frame_count("dash"))-15

func enter():
	add_child(dashDurTimer)
	dashDurTimer.one_shot = true
	sprite_2d.play("dash")
	sprite_2d.sprite_frames.set_animation_speed("dash", calculate_fps.call())
	direction = Input.get_axis("move_left", "move_right")
	if direction == 0:
		if sprite_2d.flip_h == true:
			direction = -1
		else:
			direction = 1
	player.velocity.x += direction * dashSpeed
	dash_cooldown.wait_time = dashCooldown
	dashDurTimer.start(dashDuration)

func update(delta):
	if player.is_on_floor():
		if dashDurTimer.is_stopped():
			dash_cooldown.start()
			dashStarted.emit()
			Transitioned.emit(self, "IDLE")
	else:
		if dashDurTimer.is_stopped():
			dash_cooldown.start(dashCooldown)
			dashStarted.emit()
			Transitioned.emit(self, "FALL")

func physics_update(delta):
	
	if !player.is_on_floor():
		if player.velocity.y < maxGravity:
			player.velocity.y += player.get_gravity().y * delta
	
	player.move_and_slide()

func exit():
	remove_child(dashDurTimer)
