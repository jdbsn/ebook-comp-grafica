extends SubViewportContainer

func _input(event):
	var is_mouse := event is InputEventMouse

	var local_pos := Vector2.ZERO
	if is_mouse:
		local_pos = get_global_transform_with_canvas().affine_inverse() * event.position

	if not is_mouse or (local_pos.x >= 0 and local_pos.y >= 0 and local_pos.x <= size.x and local_pos.y <= size.y):
		
		for child in get_children():
			if is_mouse:
				var ev = event.duplicate()
				ev.position = local_pos
				child.push_input(ev)
			else:
				child.push_input(event)

		accept_event()
