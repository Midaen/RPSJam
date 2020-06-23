extends Control


enum GAMETYPE{
	PIERRE,
	FEUILLE,
	CISEAU
}

func _ready():
	pass


func _on_Objectif_fin_capture(equipe):
	fin_partie(equipe)


func fin_partie(equipe):
	get_tree().paused = true
	if equipe == GAMETYPE.CISEAU: 
		$LabelVictoire.text = "Scissors Won !"
	if equipe == GAMETYPE.PIERRE: 
		$LabelVictoire.text = "Rocks Won !"
	if equipe == GAMETYPE.FEUILLE: 
		$LabelVictoire.text = "Papers Won !"
	$".".visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
