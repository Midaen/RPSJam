extends Control

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()
		
		
		
func toggle_pause():
	var new_state = not get_tree().paused
	get_tree().paused = new_state 
	visible = new_state
	if new_state: 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else : 
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_ButtonLeave_pressed():
	get_tree().quit()


func _on_ButtonContinue_pressed():
	toggle_pause()
