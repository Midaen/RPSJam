extends Node2D

onready var game = preload("res://scenes/Game.tscn")
func _ready():
	pass

func _on_Button_pressed():
	var gameScene = game.instance()
	get_parent().add_child(gameScene)
	queue_free()


