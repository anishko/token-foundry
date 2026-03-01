# Token Foundry - Forge Panel
# Version by Anish Konduri

extends Control

@onready var name_edit = $ForgeBox/NameEdit
@onready var kind_pick = $ForgeBox/KindPick
@onready var supply_spin = $ForgeBox/SupplySpin
@onready var base_spin = $ForgeBox/BaseValueSpin
@onready var btn_mint = $ForgeBox/BtnMint
@onready var mint_status = $ForgeBox/MintStatus

func _ready() -> void:
	# make the button visible + obvious
	btn_mint.text = "Mint Asset"
	btn_mint.custom_minimum_size = Vector2(180, 44)

	# name placeholder so it doesn't look empty
	name_edit.placeholder_text = "Asset name (ex: BTC, SPY, ETH)"

	# dropdown options
	kind_pick.clear()
	kind_pick.add_item("Token")
	kind_pick.add_item("NFT")
	kind_pick.add_item("Fund")
	kind_pick.add_item("Bond-ish")
	kind_pick.add_item("Game Item")

	# numbers
	supply_spin.min_value = 1
	supply_spin.max_value = 1000000000
	supply_spin.step = 1000
	supply_spin.value = 1000000

	base_spin.min_value = 0.01
	base_spin.max_value = 100000.0
	base_spin.step = 0.01
	base_spin.value = 1.00

	btn_mint.pressed.connect(_on_mint_pressed)

	# show a starter message
	mint_status.text = "Set inputs, then press Mint Asset."

func _get_main():
	return get_tree().current_scene

func _on_mint_pressed() -> void:
	var main = _get_main()
	var my_asset = main.my_asset

	# name
	my_asset.asset_name = name_edit.text.strip_edges()
	if my_asset.asset_name == "":
		my_asset.asset_name = "New Asset"

	# kind + numbers
	my_asset.asset_kind = kind_pick.get_item_text(kind_pick.selected)
	my_asset.supply_total = int(supply_spin.value)
	my_asset.base_value = float(base_spin.value)

	# reset stats each mint
	my_asset.risk_score = 55
	my_asset.liquidity_score = 45
	my_asset.volatility_score = 60
	my_asset.quality_score = 50
	my_asset.hype_score = 30
	my_asset.clamp_scores()

	mint_status.text = "Minted: %s | Value now: %.2f" % [my_asset.asset_name, my_asset.get_current_value()]
