# Token Foundry - Main Controller
# Version by Anish Konduri

extends Control

const AssetDataScript = preload("res://scripts/asset_data.gd")
const RefinerScript = preload("res://scripts/refiner.gd")
const BacktesterScript = preload("res://scripts/backtester.gd")

@onready var root_fill = $RootFill
@onready var vbox = $RootFill/VBox
@onready var top_nav = $RootFill/VBox/TopNav
@onready var body = $RootFill/VBox/Body

@onready var btn_forge = $RootFill/VBox/TopNav/Forge
@onready var btn_refine = $RootFill/VBox/TopNav/Refine
@onready var btn_backtest = $RootFill/VBox/TopNav/Backtest

@onready var forge_panel = $RootFill/VBox/Body/ForgePanel
@onready var refine_panel = $RootFill/VBox/Body/RefinePanel
@onready var backtest_panel = $RootFill/VBox/Body/BacktestPanel

var my_asset
var my_refiner
var my_backtester

func _ready() -> void:
	randomize()

	my_asset = AssetDataScript.new()
	my_refiner = RefinerScript.new()
	my_backtester = BacktesterScript.new()

	# button clicks
	btn_forge.pressed.connect(func(): _show_panel(forge_panel))
	btn_refine.pressed.connect(func(): _show_panel(refine_panel))
	btn_backtest.pressed.connect(func(): _show_panel(backtest_panel))

	# layout once now, then whenever window changes
	get_viewport().size_changed.connect(_apply_layout)

	# make nav buttons actually show (web editor safe)
	_setup_top_nav()

	_apply_layout()
	_show_panel(forge_panel)

func _setup_top_nav() -> void:
	# give the bar height
	top_nav.custom_minimum_size = Vector2(0, 60)

	# make sure buttons are not "tiny"
	_make_button_visible(btn_forge, "Forge")
	_make_button_visible(btn_refine, "Refine")
	_make_button_visible(btn_backtest, "Backtest")

func _make_button_visible(b: Button, txt: String) -> void:
	# basic button sizing so you can SEE it
	b.text = txt
	b.custom_minimum_size = Vector2(160, 44)

	# force size flags (makes them take space in the HBox)
	b.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	b.size_flags_vertical = Control.SIZE_SHRINK_CENTER

	# give a simple style so it stands out
	var normal = StyleBoxFlat.new()
	normal.bg_color = Color(0.12, 0.12, 0.12, 1.0)
	normal.border_width_left = 2
	normal.border_width_top = 2
	normal.border_width_right = 2
	normal.border_width_bottom = 2
	normal.border_color = Color(0.35, 0.35, 0.35, 1.0)
	normal.corner_radius_top_left = 8
	normal.corner_radius_top_right = 8
	normal.corner_radius_bottom_left = 8
	normal.corner_radius_bottom_right = 8

	var hover = normal.duplicate()
	hover.bg_color = Color(0.18, 0.18, 0.18, 1.0)

	var pressed = normal.duplicate()
	pressed.bg_color = Color(0.08, 0.08, 0.08, 1.0)

	b.add_theme_stylebox_override("normal", normal)
	b.add_theme_stylebox_override("hover", hover)
	b.add_theme_stylebox_override("pressed", pressed)

	b.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	b.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))
	b.add_theme_color_override("font_pressed_color", Color(1, 1, 1, 1))

func _apply_layout() -> void:
	var s = get_viewport_rect().size

	root_fill.position = Vector2.ZERO
	root_fill.size = s

	vbox.position = Vector2.ZERO
	vbox.size = s

	# top nav stays at top
	top_nav.position = Vector2.ZERO
	top_nav.size = Vector2(s.x, max(top_nav.custom_minimum_size.y, 60.0))

	# body below it
	var nav_h = top_nav.size.y
	body.position = Vector2(0, nav_h)
	body.size = Vector2(s.x, max(s.y - nav_h, 1))

	# panels fill body
	forge_panel.position = Vector2.ZERO
	refine_panel.position = Vector2.ZERO
	backtest_panel.position = Vector2.ZERO

	forge_panel.size = body.size
	refine_panel.size = body.size
	backtest_panel.size = body.size

func _show_panel(panel_to_show) -> void:
	forge_panel.visible = false
	refine_panel.visible = false
	backtest_panel.visible = false

	panel_to_show.visible = true

	if panel_to_show == refine_panel:
		refine_panel.call("refresh_stats")
	if panel_to_show == backtest_panel:
		backtest_panel.call("refresh_view")
