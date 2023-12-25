extends CharacterBody2D
class_name Player

signal player_tilemap
signal player_damage

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -250.0

var double_jump = false
var direction = 0
var looking = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var double_jump_used = false
var anim_locked = false
var anim_ready = false
var animLockers = [
	"double_jump",
	"hit"
]

@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

func _ready():
	anim_ctrl('RESET')

func _process(_delta):
	if Input.is_key_pressed(KEY_Q):
		player_tilemap.emit(position, direction, looking)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

		if Input.is_action_just_pressed("ui_accept") && !anim_locked && !double_jump_used:
			anim_ctrl("double_jump")
			double_jump_used = true
			anim_locked = true
			velocity.y = JUMP_VELOCITY
			$sounds/jump.play()
	elif double_jump_used:
		double_jump_used = false
	
	if is_on_floor() && anim.current_animation == "double_jump":
		anim_ctrl("idle")
		anim_locked = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			$sounds/jump.play()


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED

		sprite.flip_h = direction < 0
		looking = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	process_anim_ctrl()

func process_anim_ctrl():
	if is_on_floor():
		if velocity.x == 0:
			anim_ctrl("idle")
		elif anim.assigned_animation != 'run':
			anim_ctrl("run")
	else:
		if velocity.y < 0:
			anim_ctrl('jump')
		else:
			anim_ctrl('fall')

func hit(damage: float):
	print('hit')
	var vel_x = SPEED * looking

	player_damage.emit(damage)
	
	velocity.x -= (vel_x) * (SPEED - 100)
	velocity.y = JUMP_VELOCITY

	if velocity.x > 1000 || velocity.x < -1000:
		velocity.x = SPEED
		print(velocity.x)
		print("velocity")
	
	anim_ctrl("hit")
	anim_locked = true

	move_and_slide()

func _on_animation_end(animation):
	if animation in animLockers:
		print('animatiion unlocked')
		anim_locked = false

		if animation == "double_jump" && !is_on_floor():
			anim_ctrl("fall")
	elif animation == "apear":
		anim_ctrl("idle")
		anim_ready = true

func anim_ctrl(animation: String):
	if !anim_ready || anim_locked:
		return

	anim.play(animation)
