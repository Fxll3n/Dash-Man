extends State
class_name JUMP

@export var jumpStrength := 400
@export var moveSpeed := 170

@onready var jump_player: AudioStreamPlayer = $"../../JumpPlayer"

var sfx = preload("res://assets/sound/sounds/jump.wav")
var didPlay = false
var direction = 0

func enter():
	jump_player.stream = sfx
	jump_player.play()
	sprite_2d.play("jump")
	player.velocity.y = -jumpStrength
	direction = Input.get_axis("move_left", "move_right")

func update(delta):
	animate()
	if player.velocity.y > 0:
		Transitioned.emit(self, "FALL")
	elif player.is_on_floor():
		Transitioned.emit(self, "IDLE")
	elif Input.is_action_just_pressed("dash"):
		if dash_cooldown.is_stopped():
			Transitioned.emit(self, "DASH")

func physics_update(delta):
	if !player.is_on_floor():
		if player.velocity.y < maxGravity:
			player.velocity.y += player.get_gravity().y * delta
	player.velocity.x = move_toward(player.velocity.x, (direction * moveSpeed * 20) * delta, 1)
	player.move_and_slide()
	
func animate():
	if direction < 0:
		sprite_2d.flip_h = true
	elif direction > 0:
		sprite_2d.flip_h = false
