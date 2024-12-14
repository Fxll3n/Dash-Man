extends Node
class_name State

@onready var sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

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
