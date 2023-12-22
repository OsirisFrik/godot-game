extends CharacterBody2D
class_name Player


@export var SPEED = 300.0
var JUMP_VELOCITY = -400.0
var double_jump = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animBlock = false
var animBlockers = [
	"jump",
	"fall",
	"double_jump"
]

@onready var sprite = $Sprite2D
@onready var anim = $Sprite2D/AnimationPlayer


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			print(JUMP_VELOCITY)
			velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED

		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	anim_ctrl()

func anim_ctrl():
	if is_on_floor():
		if velocity.x == 0:
			anim.play("idle")
		else:
			anim.play("run")
	else:
		if velocity.y < 0:
			anim.play('jump')
		else:
			anim.play('fall')

func _on_saw_body_entered(body):
	print(body)

func hit():
	velocity.x = move_toward(velocity.x, -5, SPEED)
	anim.play("hit")
