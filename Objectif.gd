extends Spatial

export var chargement = 0 
export var total = 1000
export var count_inside = 0

func _ready():
	pass

func _process(delta):
	if count_inside:
		chargement += 1 
		print(count_inside)


func _on_Area_area_exited(area):
	print("Zone Exited")
	count_inside -= 1 


func _on_Area_area_entered(area):
	print("Zone Entered")
	count_inside += 1 
