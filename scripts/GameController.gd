extends Node2D

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
					self._place_icon(GameState.state.place_cache[0], coords[0], coords[0])
					GameState.state.place_cache = []
				"place_bank":
					self._place_icon(GameState.state.place_cache[0], coords[0], coords[0])
					GameState.state.place_cache = []		
				_:
					print("guh")
#
# 0FFSHORE funcs
#


func _init_playtest():
	_init_ui()
	
func _init_ui():
	$GUI/UiController/corpname.text = $GameState.state.corp_name
	_update_cash(0)
	_update_accounts(0)

func _update_cash(amt):
	var new_cash_total = $GameState.state.total_cash + amt
	$GameState.state.total_cash = new_cash_total
	$GUI/UiController/total_cash.text = "$ " + str(new_cash_total)

func _update_accounts(amt):
	var new_accounts_total = $GameState.state.total_accounts + amt
	$GameState.state.total_accounts = new_accounts_total
	$GUI/UiController/total_accounts.text = "$ " + str(new_accounts_total)
	
func _place_icon(data, x, y):
	var icon = TextureButton.new()
	icon.texture_normal = load(data.icon_img)
	icon.set_global_position(Vector2(x, y))
	icon.hint_tooltip = data.name
	icon.connect("pressed", $GUI/UiController, "_show_op_info_menu", [data.asset])
	$Camera2D/IconController.add_child(icon)
	
	self._update_cash(0 - data.upfront)
	
	GameState.state.mode = "look"
	GameState.state.available_ops.erase(data.asset)
	GameState.state.current_ops[data.asset] = data

