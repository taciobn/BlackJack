extends Node2D

var to
var vel = 200
var fron
var w = 0
var valor
var sprite_buffer 
var costas = load("res://Sprites/PNG-cards-1.3/costas.png")
var flip = false


func _ready():
	sprite_buffer = get_node("Sprite").get_texture()
	set_process(false)
	pass

func muve(pos):
	set_process(true)
	get_node("Audio").play()
	to = pos
	
	pass
	
func _process(delta):
	w += 0.001
	
	fron = get_global_position()
	var dir = Vector2(lerp(fron.x,to.x,w),lerp(fron.y,to.y,w))
	set_global_position(dir)
	
	if w >=1:
		set_process(false)
	pass


func flip():
	if flip:
		get_node("Sprite").set_texture(sprite_buffer)
		flip = false
	else:
		get_node("Sprite").set_texture(costas)
		flip = true
		
	pass 
