extends Control

#
# OPERATIONS
#

func _on_new_op_btn_pressed():
	init_new_op_menu()
	
func init_new_op_menu():
	reset_op_menu()
	
	$GlobalModals/AddOperation/text.text = generate_op_text()
	$GlobalModals/AddOperation/img.texture = load("res://textures/ui/new_op_menu_img.png")
	
	for op in GameState.state.available_ops:
		op = GameState.canonical_ops[op]
		var op_button = Button.new()
		op_button.text = op.button_text + " in " + op.location
		op_button.connect("pressed", self, "_op_proposal", [op])
			
		$GlobalModals/AddOperation/OpButtons.add_child(op_button)
	
	$GlobalModals/AddOperation.show()

func generate_op_text():
	var u_influence = int(GameState.state.underworld_influence)
	var text = ""
	
	if u_influence in range(0,25):
		text = "After conferring with some contacts, it appears your underworld connections are limited. However a few opportunities have arisen."
	elif u_influence in range(25,50):
		text = "Your influence among the grayer markets is making waves as people whisper about " + GameState.state.corp_name + " in warehouses and diners."
	elif u_influence in range(50,80):
		text = "Thanks to your wide-ranging network, a plethora of opportunities are knocking down your bunker door."
	else:
		text = "You are the most sought after fixer and underworld operator in the hemisphere. Careful not to fly too high."
		
	return text

func _op_proposal(op):
	reset_op_menu()
	var op_text = ""
	var op_info = ""
	
	op_text = "I got a " + op.button_text + " out in " + op.location + ". If you front me $" + str(op.upfront) + " I can guarantee you $" + str(op.income) + " " + str(op.schedule) + ".\n\n"
	op_info = "Asset: " + op.asset + "\n\nRating: " + str(op.rating) + "\n\nFacility: " + op.facility
	
	$GlobalModals/AddOperation/text.text = op_text + op_info
	$GlobalModals/AddOperation/img.texture = load(op.proposal_img)
	
	var yes_btn = Button.new()
	var back_btn = Button.new()
	
	yes_btn.text = "Sounds good, let's do this."
	back_btn.text = "Let me get back to you."
	
	yes_btn.connect("pressed", self, "_place_op", [op])
	back_btn.connect("pressed", self, "init_new_op_menu")
	
	$GlobalModals/AddOperation/OpButtons.add_child(yes_btn)
	$GlobalModals/AddOperation/OpButtons.add_child(back_btn)

func _place_op(op):
	GameState.state.mode = "place_op"
	GameState.state.place_cache = [op]
	reset_op_menu()
	$GlobalModals/AddOperation.hide()

func reset_op_menu():
	clear_container($GlobalModals/AddOperation/OpButtons)
	$GlobalModals/AddOperation/img.texture = null
	$GlobalModals/AddOperation/text.text = ""

func show_op_info_menu(op):
	var op_data = GameState.state.current_ops[op]

#
# BANKING
#

func _on_new_bank_btn_pressed():
	init_new_bank_menu()
	
func init_new_bank_menu():
	reset_bank_menu()
	
	$GlobalModals/AddBank/text.text = "Please select which firm you are interested in banking with."
	$GlobalModals/AddBank/img.texture = load("res://textures/ui/bank_menu.png")
	
	for bank in GameState.state.available_banks:
		var bank_button = Button.new()
		bank_button.text = bank
		bank = GameState.canonical_banks[bank]
		bank_button.connect("pressed", self, "_bank_detail", [bank])

			
		$GlobalModals/AddBank/BankButtons.add_child(bank_button)
	
	$GlobalModals/AddBank.show()
	
func _bank_detail(bank):
	reset_bank_menu()
	
	var bank_info = "Name: " + bank.name + "\n\nLocation: " + bank.location + "\n\n Minimum Deposit: " + str(bank.min_amount) + "\n\n Interest: " + str(bank.interest) + "%\n\n"
	
	$GlobalModals/AddBank/text.text = bank_info
	$GlobalModals/AddBank/img.texture = load(bank.proposal_img)
	
	var yes_btn = Button.new()
	var back_btn = Button.new()
	
	yes_btn.text = "Open an account with " + bank.name
	back_btn.text = "I'm evaluating other options at this time."
	
	yes_btn.connect("pressed", self, "_place_bank", [bank])
	back_btn.connect("pressed", self, "init_new_bank_menu")
	
	$GlobalModals/AddBank/BankButtons.add_child(yes_btn)
	$GlobalModals/AddBank/BankButtons.add_child(back_btn)
		
func _place_bank(bank):
	GameState.state.mode = "place_bank"
	GameState.state.place_cache = [bank]
	reset_bank_menu()
	$GlobalModals/AddBank.hide()

func reset_bank_menu():
	clear_container($GlobalModals/AddBank/BankButtons)
	$GlobalModals/AddBank/img.texture = null
	$GlobalModals/AddBank/text.text = ""

#
# CONNECTIONS
#

func summon_connect_menu():
	var from = GameState.state.connect_from_cache
	var to = GameState.state.connect_to_cache
	
	_populate_placement_menu(from, to)
	$GlobalModals/MakePlacement.show()
	
func _populate_placement_menu(from, to):
	_clear_placement_menu()
	$GlobalModals/MakePlacement/from.texture = load(from.data.proposal_img)
	$GlobalModals/MakePlacement/to.texture = load(to.data.proposal_img)
	$GlobalModals/MakePlacement/fromlabel.text = from.data.name
	$GlobalModals/MakePlacement/tolabel.text = to.data.name
	$GlobalModals/MakePlacement/AssetOption.add_item("Cash")
	_populate_asset_amount_options()
	
	
func _populate_asset_amount_options():
	var item_str
	for i in range(1, 11):
		item_str = "$"+str(i)+"k"
		$GlobalModals/MakePlacement/AmountOption.add_item(item_str)
		
func _clear_placement_menu():
	$GlobalModals/MakePlacement/from.texture = null
	$GlobalModals/MakePlacement/to.texture = null
	$GlobalModals/MakePlacement/fromlabel.text = ""
	$GlobalModals/MakePlacement/tolabel.text = ""
	$GlobalModals/MakePlacement/AssetOption.clear()
	$GlobalModals/MakePlacement/AmountOption.clear()

func _on_MakePlacement_NO_pressed():
	_clear_placement_menu()
	$GlobalModals/MakePlacement.hide()

func _on_MakePlacement_hide():
	GameState.state.mode = "look"
	GameState.state.connect_from_cache = null
	GameState.state.connect_to_cache = null

func _on_MakePlacement_OK_pressed():
	var connection = {}
	var from_node = GameState.state.connect_from_cache
	var to_node = GameState.state.connect_to_cache
	var placement_idx = $GlobalModals/MakePlacement/AmountOption.selected
	var placement_amount = $GlobalModals/MakePlacement/AmountOption.get_item_text(placement_idx)
	print(placement_amount)
	placement_amount = placement_amount.replace("$", "").replace("k", "")
	placement_amount = int(placement_amount) * 1000
	connection["amount"] = placement_amount

	connection["schedule"] = $GlobalModals/MakePlacement/ScheduleOption.selected
	
	connection["from"] = GameState.state.connect_from_cache.name
	connection["to"] = GameState.state.connect_to_cache.name

	var line = Line2D.new()
	var from_center = from_node.rect_position + (from_node.rect_size / 2)
	var to_center = to_node.rect_position + (to_node.rect_size / 2)
	line.add_point(from_center)
	line.add_point(to_center)
	line.width = 5
	line.default_color = Color.blue
	GameState.state.connection_line_cache = line
	GameState.emit_signal("draw_connection")
	
	GameState.state.connections.append(connection)
	_on_MakePlacement_NO_pressed()
#
# UTILITY FUNCTIONS
#

func clear_container(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


func _on_Splash_pressed():
	$Splash.visible = false
	$BottomNav.visible = true

