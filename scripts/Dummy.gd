extends KinematicBody

enum GAMETYPE{
	PIERRE,
	FEUILLE,
	CISEAU
}
onready var timer = $Timer
export var ACCELERATION = 5
export var MAX_SPEED = 100
export var game_type = GAMETYPE.CISEAU
onready var bullet = preload("res://scenes/Bullet.tscn")

var velocity = Vector3.ZERO

var space_state
var target

func _ready():
	timer.stop()
	space_state = get_world().direct_space_state


func _physics_process(delta):
	if timer.is_stopped():
		fire()
		timer.set_wait_time(3)
		timer.start()
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP)
			move_to_target(delta)

func _on_HitBox_area_entered(area):
	if area.is_in_group("Bullet"):
		if game_type == GAMETYPE.CISEAU and area.game_type == GAMETYPE.PIERRE:
			queue_free()
			print("a")
		elif game_type == GAMETYPE.PIERRE and area.game_type == GAMETYPE.FEUILLE:
			queue_free()
			print("b")
		elif game_type == GAMETYPE.FEUILLE and area.game_type == GAMETYPE.CISEAU:
			queue_free()
			print("c")
		

func fire():
	var tmpBlt = bullet.instance()
	tmpBlt.velocity = Vector3(0,0,-10)
	tmpBlt.game_type = game_type
	tmpBlt.transform = $Spatial/Fire.global_transform
	$".".get_parent().add_child(tmpBlt)

func _on_Timer_timeout():
	timer.stop()
	
func deplacement(delta):
	pass


func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * MAX_SPEED *3 * delta, Vector3.UP)

func _on_Vision_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")


func _on_Vision_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		print(body.name + " exited")
