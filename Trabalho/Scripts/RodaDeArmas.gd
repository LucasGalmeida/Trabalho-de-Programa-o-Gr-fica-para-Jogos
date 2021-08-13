extends Node2D


onready var armaAtual = $Pistola

var armas = []

# Called when the node enters the scene tree for the first time.
func _ready():
	armas = get_children()
	
	for arma in armas:
		arma.hide()
	
	armaAtual.show()

func _process(delta):
	if armaAtual.automatica and Input.is_action_pressed("Shoot"):
		armaAtual.shoot()

func getCurrentWeapon():
	return armaAtual

func reload():
	armaAtual.reload()
	
func setAmmo(arma, qtd):
	arma.reserva += qtd

func switch_weapon(arma):
	if arma == armaAtual or arma.municao == 0:
		return

	armaAtual.hide()
	arma.show()
	armaAtual = arma

func _unhandled_input(event: InputEvent):
	if not armaAtual.automatica and event.is_action_pressed("Shoot"):
		armaAtual.shoot()
	elif event.is_action_pressed("Reload"):
		armaAtual.reload()
	elif event.is_action_released("arma1"):
		switch_weapon(armas[0])
	elif event.is_action_released("arma2"):
		switch_weapon(armas[1])
