
extends Sprite2D
class_name ProceduralSegment
@export var radius = 50
@export var owned_bone : Bone2D
@export var deg_offset := 0.0

var recently_rotated = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if owned_bone:
		owned_bone.global_position = global_position
		owned_bone.global_rotation_degrees = global_rotation_degrees + 90

func _draw() -> void:
	draw_circle(to_local(global_position), 5, Color(0, 0, 1))
	draw_circle(to_local(global_position), radius, Color(0, 0, 1), false)
