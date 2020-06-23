extends KinematicBody

enum GAMETYPE{
	PIERRE,
	FEUILLE,
	CISEAU
}
onready var timer = $Timer
onready var death_timer = $DeathTimer
export var ACCELERATION = 5
export var MAX_SPEED = 100
export var game_type = GAMETYPE.CISEAU
onready var bullet = preload("res://scenes/Bullet.tscn")
export var initial_spawn = Vector3.ZERO
export var objecive_vector = Vector3.ZERO
export var survive_vector = Vector3.ZERO
var is_alive = true

var velocity = Vector3.ZERO

var space_state
var target

func _ready():
	timer.stop()
	space_state = get_world().direct_space_state


func _physics_process(delta):
	if is_alive:
		if timer.is_stopped():
			fire()
			timer.set_wait_time(3)
			timer.start()
		if target:
			var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
			if result and result.collider.is_in_group("Player") and test_target(target):
				look_at(target.global_transform.origin, Vector3.UP)
			if result and result.collider.is_in_group("Dummy") and test_target(target) :
				look_at(target.global_transform.origin, Vector3.UP)
			if result and result.collider.is_in_group("Player") and !test_target(target) :
				look_at(survive_vector, Vector3.UP)
			move_to_target(delta)
		else :
			look_at(objecive_vector, Vector3.UP)
			move_to_target(delta)


func _on_HitBox_area_entered(area):
	if is_alive:
		if area.is_in_group("Bullet"):
			if game_type == GAMETYPE.CISEAU and area.game_type == GAMETYPE.PIERRE:
				death()
			elif game_type == GAMETYPE.PIERRE and area.game_type == GAMETYPE.FEUILLE:
				death()
			elif game_type == GAMETYPE.FEUILLE and area.game_type == GAMETYPE.CISEAU:
				death()
		

func fire():
	var tmpBlt = bullet.instance()
	tmpBlt.velocity = Vector3(0,0,-10)
	tmpBlt.game_type = game_type
	tmpBlt.transform = $Spatial/Fire.global_transform
	$".".get_parent().add_child(tmpBlt)

func _on_Timer_timeout():
	timer.stop()
	


func move_to_target(delta):
	var direction
	if target :
		direction = (target.transform.origin - transform.origin).normalized()
	else : 
		direction = (objecive_vector - transform.origin).normalized()
	move_and_slide(direction * MAX_SPEED *3 * delta, Vector3.UP)

func _on_Vision_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")


func _on_Vision_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		print(body.name + " exited")


func _on_DeathTimer_timeout():
	respawn()


func respawn():
	death_timer.stop()
	is_alive = true
	$".".translation = initial_spawn

func death():
	#playback.travel("Death")
	death_timer.set_wait_time(3)
	death_timer.start()
	is_alive = false

func test_target(target):
	if game_type == GAMETYPE.PIERRE and target.game_type == GAMETYPE.CISEAU:
		return true
	elif game_type == GAMETYPE.FEUILLE and target.game_type == GAMETYPE.PIERRE:
		return true
	elif game_type == GAMETYPE.CISEAU and target.game_type == GAMETYPE.FEUILLE:
		return true
	else : 
		return false
