extends AnimationTree

var playback = AnimationNodeStateMachinePlayback
func _ready():
	playback = get("parameters/playback")
	playback.start("Idle")
	active = true

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		playback.travel("Throw")



func _on_AnimationPlayer_animation_finished(anim_name):
		playback.travel("Idle")
