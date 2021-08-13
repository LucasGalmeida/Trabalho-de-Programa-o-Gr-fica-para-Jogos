extends Area2D

onready var noPlayer = get_node("/root/Main/Player")
onready var noRodaDeArmas = get_node("/root/Main/Player/RodaDeArmas")
onready var metralhadora = preload("res://Assets/Top-down Shooter Asset Pack from Kenney/PNG/weapon_machine.png")
onready var vida = preload("res://Assets/HP.jpg")

onready var imagem = $Sprite
var itemDropado = ""
var armas = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	armas = noRodaDeArmas.get_children()
	
	randomize()
	
	var item = randi() % 10 + 1	
	
	# Dropa nada
	if item < 5:
		pass
		
	elif item >= 5 and item < 9:
		# dropa arma
		if item == 5 or item == 6:
			imagem.set_texture(metralhadora)
			itemDropado = "metralhadora"
		else:
			pass
		
	elif item >= 9:
		#dropa vida
		var escala = Vector2((0.2),(0.2))
		imagem.set_texture(vida)
		imagem.set_scale(escala)
		itemDropado = "vida"
		
	pass # Replace with function body.


func _on_DropComum_body_entered(body):
	if itemDropado == "metralhadora":
		if armas[1].municao == 0:
			armas[1].municao = 30
		else:
			noRodaDeArmas.setAmmo(armas[1], 30)
		queue_free()
	elif itemDropado == "vida":		
		noPlayer.health += 3
		queue_free()
	else:
		pass
