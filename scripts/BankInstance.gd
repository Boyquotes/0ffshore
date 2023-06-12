extends TextureButton

var data = {}

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
	$PopupMenu.show()


func _on_OK_pressed():
	$Info.hide()

# 0 info, 1 manage, 2 connect
func _on_PopupMenu_index_pressed(index):
	match index:
		0:
			populate_bank_info(self.data)
			$Info.show()
		1:
			pass
		2:
			pass
