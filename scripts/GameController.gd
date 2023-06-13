extends Node2D

var op_instance = load("res://scenes/OpInstance.tscn")
var bank_instance = load("res://scenes/BankInstance.tscn")

# Built-in funcs

func _ready():
	_init_playtest()

func _update():
	pass

func _input(event):
	if event is InputEventMouseButton:

		var coords = get_viewport().get_mouse_position()
		
		# EVERYTHING IS MODE BASED - THE MODE IS GOD
		# RESPECT ALL MODES
		
		if event.button_index == BUTTON_LEFT and event.pressed:
			match GameState.state.mode:			
				"place_op":
					self._place_icon(GameState.state.place_cache[0], "op", coords[0], coords[0])
					GameState.state.place_cache = []
				"place_bank":
					self._place_icon(GameState.state.place_cache[0], "bank", coords[0], coords[0])
					GameState.state.place_cache = []		

#
# 0FFSHORE funcs
#


func _init_playtest():
	_init_ui()
	_connect_signals()
	
func _init_ui():
	$GUI/UiController/corpname.text = $GameState.state.corp_name
	_update_cash(0)
	_update_accounts(0)
	
func _connect_signals():
	GameState.connect("summon_connect_menu", $GUI/UiController, "summon_connect_menu")
	GameState.connect("draw_connection", self, "draw_connection")

func _update_cash(amt):
	var new_cash_total = $GameState.state.total_cash + amt
	$GameState.state.total_cash = new_cash_total
	$GUI/UiController/total_cash.text = "$ " + str(new_cash_total)

func _update_accounts(amt):
	var new_accounts_total = $GameState.state.total_accounts + amt
	$GameState.state.total_accounts = new_accounts_total
	$GUI/UiController/total_accounts.text = "$ " + str(new_accounts_total)

func draw_connection():
	var line = GameState.state.connection_line_cache
	$Camera2D/ConnexController.add_child(line)
	GameState.state.connection_line_cache = null

	
func _place_icon(data, type, x, y):
	var instance
	
	match type:
		"op":
			instance = op_instance.instance()
		"bank":
			instance = bank_instance.instance()
			
	instance.create(data)
	instance.set_global_position(Vector2(x, y))
	instance.set_popup_position(Vector2(x, y))
	instance.set_info_position(Vector2(x,y-200))
	instance.hint_tooltip = data.name

	$Camera2D/IconController.add_child(instance)
	
	#self._update_cash(0 - data.upfront)
	
	GameState.state.mode = "look"
