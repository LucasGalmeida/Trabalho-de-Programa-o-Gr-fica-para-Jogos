extends Node2D

onready var roda = load("res://Scenes/UI/RodaDeArmasTela.tscn").instance()
onready var enemysT1 = load("res://Scenes/EnemyT1.tscn")

var dificuldadeT1 = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnDeInimigos.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	$GUI.setArmaAtual($Player.rodaDeArmas.armaAtual)
	$GUI.setHP($Player.health)
	
	if Input.is_action_pressed("Roda"):
		get_tree().get_root().add_child(roda)
		
	if Input.is_action_just_released("Roda"):
		roda.get_node("Pistola").self_modulate = Color(1, 1, 1, 1)
		roda.get_node("Metralhadora").self_modulate = Color(1, 1, 1, 1)
		get_tree().get_root().remove_child(roda)

func _on_SpawnDeInimigos_timeout():
	randomize()
	#tipoInimigo = randi() % 2
	var tipoInimigo = 0
	
	if tipoInimigo == 0:
		var qtd = randi() % dificuldadeT1 + 1
		dificuldadeT1 += 1
		for _i in range(0, qtd):
			var enemy = enemysT1.instance()
			randomize()
			enemy.position.x = rand_range(50, 900)
			enemy.position.y = -100
			add_child(enemy)
