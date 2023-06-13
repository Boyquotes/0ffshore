extends TextureButton

var data = {}

func create(data):
	self.data = data
	self.texture_normal = load(self.data.icon_img)
	self.populate_op_info(self.data)
	
	GameState.state.current_ops.append(self)
	
func populate_op_info(data):
	var op_txt = "Name: " + data.name + "\n\nLocation: " + data.location + "\n\nFacility: " + data.facility + "\n\nOperating cost: " + str(data.operating_cost) + "\n\nIncome: " + str(data.income) + " " + data.schedule
	$Info/op_info_text.text = op_txt

func set_popup_position(pos):
	$PopupMenu.set_global_position(pos)

func set_info_position(pos):
	$Info.set_global_position(pos)	

func _on_OpInstance_pressed():
	if GameState.state.mode == "connect":
		_set_connect_to()
	else:
		$PopupMenu.show()


func _on_OK_pressed():
	$Info.hide()

# 0 info, 1 manage, 2 connect
func _on_PopupMenu_index_pressed(index):
	match index:
		0:
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
