extends Spatial

export var chargement = 0 
export var total = 1000
export var count_inside = 0

enum GAMETYPE{
	PIERRE,
	FEUILLE,
	CISEAU
}
export var game_type = GAMETYPE.CISEAU

signal fin_capture(equipe)

func _ready():
	pass

func _process(delta):
	print(count_inside)
	if count_inside:
		chargement += 1 
	if test_capture():
		emit_signal("fin_capture",game_type)

func test_capture():
	return chargement >= total
	

func test_gametype(target):
	return game_type == target.game_type

func _on_Area_body_entered(body):
	if body.is_in_group("Player") and test_gametype(body):
		count_inside += 1 
	if body.is_in_group("Dummy") and test_gametype(body):
		count_inside += 1 

func _on_Area_body_exited(body) :
	if body.is_in_group("Player") and test_gametype(body):
		count_inside -= 1 
	if body.is_in_group("Dummy") and test_gametype(body):
		count_inside -= 1 
