
extends Node2D

var speed = 250
const TURN_SPEED = 3.5
var current_turn_speed = 0

var current_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint():
		$"../Target".global_position = get_viewport().get_mouse_position()
	
	current_turn_speed = TURN_SPEED * remap(current_speed, 0, speed, 0, 1)
	var previous_segment : Node2D = null
	var previous_previous_segment : Node2D = null
	for segment : Node2D in get_children():
		if !segment is ProceduralSegment:
			continue
		
		if previous_segment == null:
			var target_angle = ($"../Target".global_position - segment.global_position).angle()
			var current_angle = segment.rotation
			var new_angle = lerp_angle(current_angle, target_angle, current_turn_speed * delta)
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or (Engine.is_editor_hint() and segment.global_position.distance_to($"../Target".global_position) > 100):
				current_speed = move_toward(current_speed, speed, (speed * 0.5) * delta)
				segment.recently_rotated = new_angle - current_angle
				segment.rotate(segment.recently_rotated)
			else:
				current_speed = move_toward(current_speed, 0, (speed * 2) * delta)
			segment.global_position = segment.global_position.move_toward(segment.global_position + Vector2(1000, 0).rotated(segment.rotation), current_speed * delta)
			previous_segment = segment
		else:
			var target_angle = (previous_segment.global_position - segment.global_position).angle()
			var current_angle = segment.rotation
			var new_angle = lerp_angle(current_angle, target_angle, current_turn_speed * 3 * delta)
			segment.recently_rotated = new_angle - current_angle
			segment.rotate(segment.recently_rotated)
			var prev_pos = previous_segment.global_position
			var segment_pos = segment.global_position
			var point_distance = prev_pos.distance_to(segment_pos)
			if (point_distance == 0):
				return
			var direction_angle = (segment_pos - prev_pos).angle()
			var back_angle = previous_segment.rotation + deg_to_rad(180)
			var mid_angle = lerp_angle(direction_angle, back_angle, 10 * delta)
			if (previous_previous_segment != null):
				var angle = rad_to_deg(get_angle_between_vectors(previous_segment.global_position, segment.global_position, previous_previous_segment.global_position))
				if (angle < 95 and angle > -95):
					previous_previous_segment.rotate(-segment.recently_rotated)
			var target_position = prev_pos + Vector2(
				previous_segment.radius * cos(mid_angle),
				previous_segment.radius * sin(mid_angle)
			)
			segment.global_position = segment_pos.move_toward(target_position, speed * 10 * delta)
			previous_previous_segment = previous_segment
			previous_segment = segment

func get_angle_between_vectors(center: Vector2, a: Vector2, b: Vector2) -> float:
	var dir_a = a - center
	var dir_b = b - center
	return dir_a.angle_to(dir_b)
