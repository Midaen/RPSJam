extends Spatial

enum GAMETYPE{
	PIERRE,
	FEUILLE,
	CISEAU
}
var rdy = false
var origin_20 = 20 
var ciseau_spawn = Vector3(20,1,-20)
var feuille_spawn = Vector3(20,1,20)
var pierre_spawn = Vector3(-20,1,0)
var pierre_objectif = Vector3(20,1,0)
var feuille_objectif = Vector3(-10,1,-20)
var ciseaux_objectif = Vector3(-10,1,20)
onready var player = preload("res://scenes/Player.tscn")
onready var dummy = preload("res://scenes/Dummy.tscn")
export var player_team = GAMETYPE.CISEAU

func _ready():
	if player_team == GAMETYPE.CISEAU :
		create_ent(GAMETYPE.FEUILLE,dummy)
		create_ent(GAMETYPE.PIERRE,dummy)
		create_ent(GAMETYPE.CISEAU,dummy)
		update_spawn()
		create_ent(GAMETYPE.FEUILLE,dummy)
		create_ent(GAMETYPE.PIERRE,dummy)
		create_ent(GAMETYPE.CISEAU,dummy)
		update_spawn()
		create_ent(GAMETYPE.FEUILLE,dummy)
		create_ent(GAMETYPE.PIERRE,dummy)
		create_ent(GAMETYPE.CISEAU,dummy)
		update_spawn()
		create_ent(GAMETYPE.FEUILLE,dummy)
		create_ent(GAMETYPE.PIERRE,dummy)
		create_ent(GAMETYPE.CISEAU,dummy)
		update_spawn()
		create_ent(GAMETYPE.PIERRE,dummy)
		create_ent(GAMETYPE.FEUILLE,dummy)
		create_ent(GAMETYPE.CISEAU,player)
	rdy = true 

func create_ent(team,type):
	var tmp_dummy = type.instance()
	tmp_dummy.game_type = team
	if team == GAMETYPE.CISEAU : 
		tmp_dummy.translation = ciseau_spawn
		tmp_dummy.initial_spawn = ciseau_spawn
		tmp_dummy.survive_vector = feuille_spawn
		tmp_dummy.objecive_vector = ciseaux_objectif
		tmp_dummy.game_type = GAMETYPE.CISEAU
	if team == GAMETYPE.PIERRE : 
		tmp_dummy.translation = pierre_spawn
		tmp_dummy.game_type = GAMETYPE.PIERRE
		tmp_dummy.initial_spawn = pierre_spawn
		tmp_dummy.survive_vector = ciseau_spawn
		tmp_dummy.objecive_vector = pierre_objectif
	if team == GAMETYPE.FEUILLE : 
		tmp_dummy.translation = feuille_spawn
		tmp_dummy.game_type = GAMETYPE.FEUILLE
		tmp_dummy.initial_spawn = feuille_spawn
		tmp_dummy.survive_vector = pierre_spawn
		tmp_dummy.objecive_vector = feuille_objectif
	$Entities.add_child(tmp_dummy)

func update_spawn(): 
	origin_20 += 5
	ciseau_spawn = Vector3(origin_20,1,-origin_20)
	feuille_spawn = Vector3(origin_20,1,origin_20)
	pierre_spawn = Vector3(-origin_20,1,origin_20-20)

func _process(delta):
	update_hud()
	$"HUD/Fps".text = "fps : "+str(delta*1000)

func update_hud():
	$HUD/LabelCiseau.text = "Ciseaux : "+str(int($ObjectifCiseau.chargement/10))
	$HUD/LabelPierre.text = "Pierre : "+str(int($ObjectifPierre.chargement/10))
	$HUD/LabelFeuille.text = "Feuille : "+str(int($ObjectifFeuille.chargement/10))
