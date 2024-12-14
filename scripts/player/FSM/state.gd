extends Node
class_name State

@onready var sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var dash_cooldown: Timer = %DashCooldown

@export var maxGravity := 3000

var player: CharacterBody2D

signal Transitioned

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(delta) -> void:
	pass
	
func physics_update(delta) -> void:
	pass
