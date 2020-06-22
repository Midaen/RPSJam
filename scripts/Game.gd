extends Spatial

enum GAMETYPE{
	PIERRE,
	FEUILLE,
	CISEAU
}
var ciseau_spawn = Vector3(20,1,-20)
var feuille_spawn = Vector3(20,1,20)
var pierre_spawn = Vector3(-20,1,0)
onready var player = preload("res://scenes/Player.tscn")
onready var dummy = preload("res://scenes/Dummy.tscn")
export var player_team = GAMETYPE.CISEAU

func _ready():
	if player_team == GAMETYPE.CISEAU :
		create_ent(GAMETYPE.FEUILLE,dummy)
		create_ent(GAMETYPE.PIERRE,dummy)
		create_ent(GAMETYPE.CISEAU,player)

func create_ent(team,type):
	var tmp_dummy = type.instance()
	tmp_dummy.game_type = team
	if team == GAMETYPE.CISEAU : 
		tmp_dummy.translation = ciseau_spawn
		tmp_dummy.initial_spawn = ciseau_spawn
		tmp_dummy.game_type = GAMETYPE.CISEAU
	if team == GAMETYPE.PIERRE : 
		tmp_dummy.translation = pierre_spawn
		tmp_dummy.game_type = GAMETYPE.PIERRE
		tmp_dummy.initial_spawn = pierre_spawn
	if team == GAMETYPE.FEUILLE : 
		tmp_dummy.translation = feuille_spawn
		tmp_dummy.game_type = GAMETYPE.FEUILLE
		tmp_dummy.initial_spawn = feuille_spawn
	$Entities.add_child(tmp_dummy)

