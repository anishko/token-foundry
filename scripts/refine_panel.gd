# Token Foundry - Refine Panel
# Version by Anish Konduri

extends Control

@onready var stats_label = $RefineBox/StatsLabel
@onready var refine_status = $RefineBox/RefineStatus

@onready var btn_audit = $RefineBox/BtnAudit
@onready var btn_liq = $RefineBox/BtnLiquidity
@onready var btn_burn = $RefineBox/BtnBurn
@onready var btn_mkt = $RefineBox/BtnMarketing
@onready var btn_stable = $RefineBox/BtnStability

func _ready() -> void:
	# make labels show on the buttons (so you can see what you're clicking)
	btn_audit.text = "Audit"
	btn_liq.text = "Liquidity"
	btn_burn.text = "Burn 2%"
	btn_mkt.text = "Marketing"
	btn_stable.text = "Stability"

	# make them a decent size
	_set_btn_size(btn_audit)
	_set_btn_size(btn_liq)
	_set_btn_size(btn_burn)
	_set_btn_size(btn_mkt)
	_set_btn_size(btn_stable)

	# connect clicks
	btn_audit.pressed.connect(func(): _do_refine("audit"))
	btn_liq.pressed.connect(func(): _do_refine("liq"))
	btn_burn.pressed.connect(func(): _do_refine("burn"))
	btn_mkt.pressed.connect(func(): _do_refine("mkt"))
	btn_stable.pressed.connect(func(): _do_refine("stable"))

	refresh_stats()

func _set_btn_size(b: Button) -> void:
	# simple size rules
	b.custom_minimum_size = Vector2(140, 42)
	b.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	b.size_flags_vertical = Control.SIZE_SHRINK_CENTER

func _get_main():
	return get_tree().current_scene

func _do_refine(kind: String) -> void:
	var main = _get_main()
	var my_asset = main.my_asset
	var my_refiner = main.my_refiner

	if kind == "audit":
		my_refiner.audit_pass(my_asset)
		refine_status.text = "Audit applied."
	elif kind == "liq":
		my_refiner.liquidity_boost(my_asset)
		refine_status.text = "Liquidity boost applied."
	elif kind == "burn":
		my_refiner.supply_burn(my_asset, 2.0)
		refine_status.text = "Burned 2% supply."
	elif kind == "mkt":
		my_refiner.marketing_push(my_asset)
		refine_status.text = "Marketing push applied."
	elif kind == "stable":
		my_refiner.stability_shield(my_asset)
		refine_status.text = "Stability shield applied."

	refresh_stats()

func refresh_stats() -> void:
	var main = _get_main()
	var my_asset = main.my_asset
	stats_label.text = my_asset.get_summary()
