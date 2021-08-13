extends Control


onready var aux = get_node("/root/Main/Player/RodaDeArmas")
var armas = []

# Called when the node enters the scene tree for the first time.
func _ready():
	armas = aux.get_children()


func _on_Pistola_pressed():
	aux.switch_weapon(armas[0])

func _on_Metralhadora_pressed():
	aux.switch_weapon(armas[1])

func mouse_entered(name):
	get_node(name).self_modulate = Color(0.15, 0.55, 0.74, 1)
	get_node(name).get_child(0).scale = Vector2(1.1,1.1)


func mouse_exited(name):
	get_node(name).self_modulate = Color(1, 1, 1, 1)
	get_node(name).get_child(0).scale = Vector2(0.9,0.9)

