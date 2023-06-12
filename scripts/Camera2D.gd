# Copyright 2017 Kamil Lewan <carmel4a97@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

extends Camera2D

# Camera control settings:
# key - by keyboard
# drag - by clicking mouse button, right mouse button by default;
# edge - by moving mouse to the window edge
# wheel - zoom in/out by mouse wheel
export (bool) var key = true
export (bool) var drag = true
export (bool) var edge = false
export (bool) var wheel = true

export (float) var zoom_out_limit = 4
export (float) var zoom_in_limit = 0.25

# Camera speed in px/s.
export (int) var camera_speed = 450 


# Value meaning how near to the window edge (in px) the mouse must be,
# to move a view.
export (int) var camera_margin = 25

# It changes a camera zoom value in units... (?, but it works... it probably
# multiplies camera size by 1+camera_zoom_speed)
const camera_zoom_speed = Vector2(0.0075, 0.0075)

# Vector of camera's movement / second.
var camera_movement = Vector2()

# Previous mouse position used to count delta of the mouse movement.
var _prev_mouse_pos = null

# Various internal variables used to calculate camera position against camera movement limits
var half_viewport_x = 0.0
var half_viewport_y = 0.0
var GUI = null
var game = null
var scale_factor = 1

var unit_queue = []
var next = 0

var tilemap_zoom = Vector2(1,1)

func _ready():
	game = get_tree().get_current_scene()
	set_h_drag_enabled(false)
	set_v_drag_enabled(false)
	set_enable_follow_smoothing(false)
	set_follow_smoothing(2)
	set_process_unhandled_input(true)

# Get centered position relative to screen size 
func get_screen_center():
	var camera_position = self.get_position()
	var vp_center = Vector2(
		camera_position.x / scale_factor,
		camera_position.y / scale_factor
	)
	return vp_center

func _physics_process(delta):
	half_viewport_x = get_viewport().size.x / scale_factor
	half_viewport_y = get_viewport().size.y / scale_factor
	
	# Move camera by keys defined in InputMap (ui_left/up/right/down).
	# But only if navigation by keyboard (key) is enabled.
	
	if key:
		# Left
		if Input.is_action_pressed("left"):
			camera_movement.x += camera_speed * delta
			print("uhghg")
		# Top
		if Input.is_action_pressed("up"):
			camera_movement.y += camera_speed * delta
		# Right
		if Input.is_action_pressed("right"):
			camera_movement.x -= camera_speed * delta
		# Bottom
		if Input.is_action_pressed("down"):
			camera_movement.y -= camera_speed * delta
			
		if Input.is_action_pressed("ui_zoom_in") and self.tilemap_zoom.x <= 2:
			self.tilemap_zoom.x += 0.025
			self.tilemap_zoom.y += 0.025
			self.scale = self.tilemap_zoom

		if Input.is_action_pressed("ui_zoom_out") and self.tilemap_zoom.x >= 0.225:
			self.tilemap_zoom.x -= 0.025
			self.tilemap_zoom.y -= 0.025
			self.scale = self.tilemap_zoom
	
	# When RMB is pressed, move camera by difference of mouse position
	if drag and Input.is_action_pressed("mouse_right_click"):
		camera_movement = _prev_mouse_pos - get_viewport().get_mouse_position()
	
	# Update position of the camera if future position will be within camera limits
	var camera_new_left = get_position().x + camera_movement.x - self.half_viewport_x
	var camera_new_right = get_position().x + camera_movement.x + self.half_viewport_x
	var camera_new_top = get_position().y + camera_movement.y - self.half_viewport_y
	var camera_new_bottom = get_position().y + camera_movement.y + self.half_viewport_y
	
	if camera_new_left > self.get_limit(0) and camera_new_right < self.get_limit(2) and camera_new_top > self.get_limit(1) and camera_new_bottom < self.get_limit(3):
		self.set_position(self.get_position() + camera_movement * 1.25)
	
	# Set camera movement to zero, update old mouse position.
	camera_movement = Vector2(0,0)
	_prev_mouse_pos = get_viewport().get_mouse_position()
