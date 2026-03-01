# Token Foundry - Asset Data
# Version by Anish Konduri

extends Node

# basic identity
var asset_name: String = "New Asset"
var asset_kind: String = "Token"

# basic numbers
var supply_total: int = 1000000
var base_value: float = 1.00

# scores 0 to 100
var risk_score: float = 55
var liquidity_score: float = 45
var volatility_score: float = 60
var quality_score: float = 50
var hype_score: float = 30

# backtest prices
var history_prices: Array[float] = []

func reset_history() -> void:
	history_prices = []

func clamp_scores() -> void:
	risk_score = clamp(risk_score, 0, 100)
	liquidity_score = clamp(liquidity_score, 0, 100)
	volatility_score = clamp(volatility_score, 0, 100)
	quality_score = clamp(quality_score, 0, 100)
	hype_score = clamp(hype_score, 0, 100)

func get_current_value() -> float:
	# simple value formula
	var good_part = (quality_score * 0.012) + (liquidity_score * 0.010) + (hype_score * 0.008)
	var bad_part = (risk_score * 0.010) + (volatility_score * 0.006)

	var multiplier = 1.0 + good_part - bad_part
	multiplier = clamp(multiplier, 0.10, 5.00)

	return base_value * multiplier

func get_summary() -> String:
	return "Name: %s\nKind: %s\nSupply: %d\nBase: %.2f\nValue: %.2f\nQuality: %d  Risk: %d\nLiquidity: %d  Volatility: %d\nHype: %d" % [
		asset_name,
		asset_kind,
		supply_total,
		base_value,
		get_current_value(),
		int(quality_score),
		int(risk_score),
		int(liquidity_score),
		int(volatility_score),
		int(hype_score)
	]
