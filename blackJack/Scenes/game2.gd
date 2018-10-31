extends Node

var pre_carta = preload("res://Scenes/Carta.tscn")
var pos_mao_jogador = Vector2(300,500)
var pos_mao_mesa = Vector2(300,180)
var valor_mao_jogador = 0
var valor_mao_mesa = 0
var dinheiro_jogador = 100
var dinheiro_mesa = 10000
var valor_aposta
var turno
onready var time = get_node("Timer")

enum TURNO{
	aposta,
	primeiraMao,
	jogador,
	mesa,
	result,
	fim,
	pausa
}


func _ready():
	turno = TURNO.aposta
	pass
	
	
	

func _process(delta):
	falido()
	match turno:
		TURNO.aposta:
			turnoAposta()
			pass
		TURNO.primeiraMao:
			pass
		TURNO.jogador:
			pass
		TURNO.mesa:
			pass
		TURNO.result:
			pass
		TURNO.fim:
			pass
		TURNO.pausa:
			pass
	pass
func falido():
	if dinheiro_jogador == 0:
		get_node("result").set_text("Voce faliu")

	if dinheiro_mesa == 0:
		get_node("result").set_text("O Cassino faliu")
	pass

func turnoAposta():
	get_aposta()
	if Input.is_action_just_pressed("ui_accept"):
		aposta = int($aposta.get_text())
		$aposta.set_text("")
		$valor_aposta.set_text(str(aposta))
		$aposta.set_visible(false)
		$result.set_text("")
		if aposta > dinheiro_jogador or aposta < 1:
			$result.set_text("Nao tem dinheiro")
		else :
			turno = TURNO.primeiraMao
		pass
	pass

func game():
	
	get_aposta()
	primeira_mao()

	pass
	
func primeira_mao():
	createDack()
	
	pegarCarta("jogador").flip()
	
	pegarCarta("mesa").flip()
	pegarCarta("jogador").flip()
	pegarCarta("mesa")
	
	
	
	pass
	
func get_aposta():
	reset()
	get_node("result").set_text("faça sua aposta")
	get_node("aposta").set_visible(true)
	pass
	
func reset():
	pos_mao_jogador = Vector2(300,500)
	pos_mao_mesa = Vector2(300,180)
	valor_mao_jogador = 0
	valor_mao_mesa = 0
	
	for i in get_node("mao_mesa").get_children():
		get_node("mao_mesa").remove_child(i)
		i.queue_free()
	for i in get_node("mao_jogador").get_children():
		get_node("mao_jogador").remove_child(i)
		i.queue_free()
	for i in get_node("Deck").get_children():
		get_node("Deck").remove_child(i)
		i.queue_free()
	createDack()
	get_node("mesa").set_text(str(calcular_valor("mesa")))
	get_node("jogador").set_text(str(calcular_valor("jogador")))
	get_node("valor_aposta").set_text("")
	pass

func createDack():

	var nipe = "hearts"
	for i in range(4):
		if i==0:
			 nipe = "hearts"
		if i==1:
			 nipe = "spades"
		if i==2:
			 nipe = "diamonds"
		if i==3:
			 nipe = "clubs"
			
		for j in range(13):
			var carta = pre_carta.instance()
			var sprite
			if j == 0:
				sprite = load(str("res://Sprites/PNG-cards-1.3/","ace","_of_",nipe,".png"))
			elif j == 10:
				sprite = load(str("res://Sprites/PNG-cards-1.3/","jack","_of_",nipe,"2.png"))
			elif j == 11:
				sprite = load(str("res://Sprites/PNG-cards-1.3/","queen","_of_",nipe,"2.png"))
			elif j == 12:
				sprite = load(str("res://Sprites/PNG-cards-1.3/","king","_of_",nipe,"2.png"))
			else :
				sprite = load(str("res://Sprites/PNG-cards-1.3/",j+1,"_of_",nipe,".png"))
			carta.get_node("Sprite").set_texture(sprite)
			carta.set_global_position(get_node("baralho").get_global_position())
			carta.set_visible(false)
			if j+1>10:
				carta.valor = 10
			else :
				carta.valor = j+1
			
			get_node("Deck").add_child(carta)
			carta.flip()
			
			pass
		
		pass

func calcular_valor(mao):
	var valores
	var valor = 0
	if mao == "jogador" :
		valores = get_node("mao_jogador").get_children()
		for i in valores :
				valor+= i.valor
		for i in valores :
				if i.valor == 1 and valor+10 <=21:
					valor+=10
		valor_mao_jogador = valor
		
	if mao == "mesa" :
		valores = get_node("mao_mesa").get_children()
		for i in valores :
				valor+= i.valor
		for i in valores :
				if i.valor == 1 and valor+10 <=21:
					valor+=10
		valor_mao_mesa = valor

	return valor
	
func pegarCarta(mao):
	var carta
	randomize()
	if get_node("Deck").get_child_count() > 0:
		
		var num = rand_range(0,get_node("Deck").get_child_count())
		
		
		carta = get_node("Deck").get_child(num) 	
		
		
		get_node("Deck").remove_child(carta)
		
		if mao == "jogador" :
			get_node("mao_jogador").add_child(carta)
			carta.muve(pos_mao_jogador)
			carta.set_visible(true)
			get_tree().paused = true
			print("true")
			pos_mao_jogador.x+=50
			calcular_valor("jogador")
		if mao == "mesa" :
			get_node("mao_mesa").add_child(carta)
			carta.muve(pos_mao_mesa)
			carta.set_visible(true)
			get_tree().paused = true
			print("true")
			pos_mao_mesa.x+=50
			calcular_valor("mesa")
	return carta
