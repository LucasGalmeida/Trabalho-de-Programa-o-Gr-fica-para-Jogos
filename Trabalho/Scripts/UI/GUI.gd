extends CanvasLayer

onready var HP = $HP
onready var municao = $"Munição"
onready var reserva = $Reserva
onready var pontuacao = $"Pontuação"

func setArmaAtual(arma):	
	municao.text = "Munição: "+str(arma.municao)+"|"
	reserva.text = str(arma.reserva)

func setHP(newHP):
	HP.text = "Vida: "+str(newHP)

func setMunicaoAtual(newAmmo):
	municao.text = str(newAmmo)

func setCapacidadeAtual(newMaxAmmo):
	reserva.text = str(newMaxAmmo)

func setScore(newScore):
	pontuacao.text = "Score: "+ str(int(pontuacao.text)+newScore)
	
func getScore():
	return pontuacao.text

