extends TextureButton

var data = {}

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and get_rect().has_point(get_local_mouse_position()):
		if event.button_index == BUTTON_RIGHT and GameState.state.mode == "look":
			_on_button_toggled(true)

func _on_button_toggled(toggled):
	var popup = $PopupMenu
	if toggled:
		popup.rect_global_position = rect_global_position + Vector2(0, rect_min_size.y)
		popup.show()
	else:
		popup.hide()

func create(data):
	self.data = data
	
	self.texture_normal = load(self.data.icon_img)
	self.populate_bank_info(self.data)
	
	GameState.state.current_ops.append(self)
	

	
func populate_bank_info(data):
	var bank_txt = "Name: " + data.name + "\n\nLocation: " + data.location + "\n\nAccount total: $" + str(data.account_total)
	$Info/bank_info_text.text = bank_txt

func set_popup_position(pos):
	$PopupMenu.set_global_position(pos)

func set_info_position(pos):
	$Info.set_global_position(pos)	

func _on_BankInstance_pressed():
	if GameState.state.mode == "connect":
		_set_connect_to()


func _on_OK_pressed():
	$Info.hide()

# 0 info, 1 manage, 2 connect
func _on_PopupMenu_index_pressed(index):
	match index:
		0:
			populate_bank_info(self.data)
			$Info.rect_global_position = rect_global_position + Vector2(0, rect_min_size.y-150)
			$Info.show()
		1:
			pass
		2:
			_set_connect_from()
			
func _set_connect_from():
	GameState.state.mode = "connect"
	GameState.state.connect_from_cache = self

func _set_connect_to():
	if !GameState.state.connect_from_cache == self:
		GameState.state.connect_to_cache = self
		GameState.emit_signal("summon_connect_menu")
