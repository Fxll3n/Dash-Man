extends State
class_name RUN

@onready var footstep_player: AudioStreamPlayer = $"../../FootstepPlayer"

@export var moveSpeed := 340
var sfx = preload("res://assets/sound/sounds/tap.wav")
var didPlay = false
var direction = 0
var calculate_run_animation_fps = func() -> float:
	return abs((moveSpeed*0.38) / sprite_2d.sprite_frames.get_frame_count("run"))

func enter():
	sprite_2d.play("run")
	footstep_player.stream = sfx
	sprite_2d.sprite_frames.set_animation_speed("run", calculate_run_animation_fps.call())

func update(delta):
	animate()
	if player.is_on_floor():
		if direction != 0:
			if Input.is_action_just_pressed("dash"):
				Transitioned.emit(self, "DASH")
			elif Input.is_action_just_pressed("move_up"):
				Transitioned.emit(self, "JUMP")
			elif Input.is_action_just_pressed("dash"):
				if dash_cooldown.is_stopped():
					Transitioned.emit(self, "DASH")
	else:
		Transitioned.emit(self, "IDLE")
	

func physics_update(delta):
	direction = Input.get_axis("move_left", "move_right")
	
	if player.is_on_floor():
		if direction:
			player.velocity.x = (direction * moveSpeed * 20) * delta
		else:
			Transitioned.emit(self, "IDLE")
	
	player.move_and_slide()

func animate():
	if direction < 0:
		sprite_2d.flip_h = true
	elif direction > 0:
		sprite_2d.flip_h = false
	
	if sprite_2d.frame % 2 == 0:
		if !didPlay:
			footstep_player.play()
			didPlay = true
	else:
		didPlay = false
