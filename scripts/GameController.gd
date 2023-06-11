extends Node2D

func _ready():
	_init_playtest()
	
func _init_playtest():
	_init_ui()
	
func _init_ui():
	$GUI/UiControl/corpname.text = $GameState.state.corp_name
	_update_cash(0)
	_update_accounts(0)

func _update_cash(amt):
	var new_cash_total = $GameState.state.total_cash + amt
	$GameState.state.total_cash = new_cash_total
	$GUI/UiControl/total_cash.text = "$ " + str(new_cash_total)

func _update_accounts(amt):
	var new_accounts_total = $GameState.state.total_accounts + amt
	$GameState.state.total_accounts = new_accounts_total
	$GUI/UiControl/total_accounts.text = "$ " + str(new_accounts_total)
