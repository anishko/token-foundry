# Token Foundry - Backtester
# Version by Anish Konduri

extends Node

func run_simulation(my_asset: Node, days_count: int = 60) -> void:
	my_asset.reset_history()

	var price_now = my_asset.get_current_value()
	my_asset.history_prices.append(price_now)

	for i in range(days_count):
		var wiggle = (my_asset.volatility_score / 100.0) * 0.08
		var drift = ((my_asset.quality_score - my_asset.risk_score) / 100.0) * 0.01

		var hype_push = (my_asset.hype_score / 100.0) * 0.008
		var liquidity_guard = (my_asset.liquidity_score / 100.0) * 0.006

		var random_step = randf_range(-wiggle, wiggle)
		var change = drift + hype_push + random_step

		if change < 0:
			change += liquidity_guard

		price_now = price_now * (1.0 + change)
		price_now = max(price_now, 0.01)

		my_asset.history_prices.append(price_now)
