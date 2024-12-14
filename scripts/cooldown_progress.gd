extends ProgressBar

@onready var dash_cooldown: Timer = %DashCooldown



func _on_dash_dash_started() -> void:
	visible = true
	max_value = dash_cooldown.wait_time
	

func _process(delta: float) -> void:
	value = dash_cooldown.time_left
	if value <= 0:
		visible = false
