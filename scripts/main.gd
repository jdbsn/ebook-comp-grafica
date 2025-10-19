extends Node

var paginas = [
	"res://scenes/capa.tscn",
	"res://scenes/pag2.tscn",
	"res://scenes/pag3.tscn",
	"res://scenes/pag4.tscn",
	"res://scenes/pag5.tscn",
	"res://scenes/pag6.tscn",
	"res://scenes/pag7.tscn",
	"res://scenes/contracapa.tscn"
]
var pagina_atual = 0

func proxima_pagina():
	print(pagina_atual)
	if pagina_atual < paginas.size() - 1:
		pagina_atual += 1
		get_tree().change_scene_to_file(paginas[pagina_atual])

func pagina_anterior():
	print(pagina_atual)
	if pagina_atual > 0:
		pagina_atual -= 1
		get_tree().change_scene_to_file(paginas[pagina_atual])

func pagina_inicial():
	print(pagina_atual)
	pagina_atual = 0
	get_tree().change_scene_to_file(paginas[pagina_atual])
