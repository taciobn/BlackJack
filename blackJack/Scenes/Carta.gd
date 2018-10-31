extends Node2D

var to
var vel = 200
var fron
var w = 0
var valor
var sprite_buffer 
var costas = load("res://Sprites/PNG-cards-1.3/costas.png")
var flip = false
const SPEED = 500.0

var begin = Vector2()
var end = Vector2()
var path = []
var navegate






func _ready():
	sprite_buffer = get_node("Sprite").get_texture()
	navegate = get_parent().get_parent().get_node("Navigation")
	set_process(false)
	pass

func muve(pos):
	begin = global_position
	end = pos
	var p = navegate.get_simple_path(begin, end, true)
	path = Array(p) # PoolVector2Array too complex to use, convert to regular array
	path.invert()
	set_process(true)
	get_node("Audio").play()
	
	pass
	
func _process(delta):
	if path.size() > 1:
		var to_walk = delta * SPEED
		while to_walk > 0 and path.size() >= 2:
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			var d = pfrom.distance_to(pto)
			if d <= to_walk:
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		var atpos = path[path.size() - 1]
		#self.global_position = atpos
		var a = self.global_position 
		var b = atpos
		var dir  = Vector2(a.x-b.x,a.y-b.y).normalized()
		move_and_slide(-dir*SPEED)
		
		if path.size() < 2:
			path = []
			set_process(false)
	else:
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
