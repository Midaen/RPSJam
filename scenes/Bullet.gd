extends Area

export var velocity = Vector3.ZERO
export var speed = 10
onready var timer = $Timer

enum GAMETYPE{
	PIERRE,
	FEUILLE,
	CISEAU
}

export var game_type = GAMETYPE.CISEAU

func _ready():
	timer.set_wait_time(3)
	timer.start()

func _physics_process(delta):
	translate(velocity*delta*speed)


func _on_Spatial_body_entered(body):
	print(body)
	queue_free()

func _on_Timer_timeout():
	queue_free()
