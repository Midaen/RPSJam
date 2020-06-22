extends KinematicBody

export var MAX_SPEED = 10
onready var cam = $Head/Camera
onready var bullet = preload("res://scenes/Bullet.tscn")
onready var timer = $Timer
onready var death_timer = $DeathTimer
export var ACCELERATION = 5
export var MOUSE_SENS = 0.3
export var CAMERA_ANGLE=0
var velocity = Vector3()
var direction = Vector3()
export var initial_spawn = Vector3.ZERO
var is_alive = true


onready var anim_tree  = $Scissor/AnimationTree
var playback 
enum GAMETYPE{
	PIERRE,
	FEUILLE,
	CISEAU
}
export var game_type = GAMETYPE.CISEAU

func _ready():
	print("Hello World")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	timer.stop()
	death_timer.set_wait_time(3)
	set_sprite()

func _physics_process(delta):
	direction = Vector3()
	velocity = Vector3.ZERO
	if is_alive : 
		if Input.is_action_pressed("ui_up"):
			direction -= transform.basis.z
		elif Input.is_action_pressed("ui_down"):
			direction += transform.basis.z
		if Input.is_action_pressed("ui_left"):
			direction -= transform.basis.x
		elif Input.is_action_pressed("ui_right"):
			direction += transform.basis.x
		direction = direction.normalized()
		velocity = velocity.linear_interpolate(direction * MAX_SPEED, ACCELERATION * delta)*1
		velocity = move_and_slide(velocity, Vector3.UP)
		if velocity == Vector3.ZERO:
			playback.travel("Idle")
		else :
			playback.travel("Running")
		
		if Input.is_action_pressed("ui_accept") and timer.is_stopped(): 
			var tmpBlt = bullet.instance()
			if playback.get_current_node() == "Running":
				playback.travel("Run_Throw")
			else : 
				playback.travel("Throw")
			tmpBlt.velocity = Vector3(0,0,-10)
			tmpBlt.game_type = game_type
			tmpBlt.transform = $Head/Position3D.global_transform
			$".".get_parent().add_child(tmpBlt)
			timer.set_wait_time(0.2)
			timer.start()

func _input(event):         
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * MOUSE_SENS))
		cam.rotate_x(deg2rad(-event.relative.y * MOUSE_SENS))
		cam.rotation.x = clamp(cam.rotation.x ,deg2rad(-20), deg2rad(20) )

func _on_Timer_timeout():
	timer.stop()

func _on_Area_area_entered(area):
	if is_alive :
		if area.is_in_group("Bullet"):
			if game_type == GAMETYPE.CISEAU and area.game_type == GAMETYPE.PIERRE:
				death()
			elif game_type == GAMETYPE.PIERRE and area.game_type == GAMETYPE.FEUILLE:
				death()
			elif game_type == GAMETYPE.FEUILLE and area.game_type == GAMETYPE.CISEAU:
				death()

func set_sprite():
	playback= anim_tree.get("parameters/playback")
	playback.start("Idle")
	

func respawn():
	playback.start("Idle")
	is_alive = true
	death_timer.stop()
	$".".translation = initial_spawn


func death():
	playback.travel("Death")
	death_timer.set_wait_time(3)
	death_timer.start()
	is_alive = false

func _on_DeathTimer_timeout():
	respawn()
