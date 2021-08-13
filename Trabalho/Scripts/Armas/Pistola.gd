extends Node2D

export (PackedScene) var Bullet

onready var pontaDaArma = $PontaDaArma
onready var CD = $CD
onready var animationPlayer = $AnimationPlayer

export var automatica = false
export var municao = 15
export var reserva = "infinito"

func reload():
	animationPlayer.play("Reload")

func _carregou():
	municao = 15
	
func shoot():
	
	if CD.is_stopped() and municao > 0 and Bullet != null:	
		# Cria uma bala
		var bullet_instance = Bullet.instance()
		
		# Adiciona a tela de main
		# Sobe para rodaDeArmas -> Jogador -> TelaPrincipal : Adiciona
		get_parent().get_parent().get_parent().add_child(bullet_instance)
		
		# Seta que a bala vai sair da ponta da arma
		bullet_instance.global_position = pontaDaArma.global_position
		
		# Faz com que o projetil seja disparado em linha reta
		bullet_instance.global_rotation = pontaDaArma.global_rotation + PI/2	
		
		# Dispara na direcao do mouse
		var target = get_global_mouse_position()
		var direction_to_mouse = bullet_instance.global_position.direction_to(target).normalized()
		bullet_instance.set_direction(direction_to_mouse)
		municao -= 1
		CD.start()
		animationPlayer.play("Flash")
	elif municao == 0:
		reload()
