# Token Foundry - Refinement Actions
# Version by Anish Konduri

extends Node

func audit_pass(my_asset: Node) -> void:
	my_asset.quality_score += 8
	my_asset.risk_score -= 12
	my_asset.hype_score -= 2
	my_asset.clamp_scores()

func liquidity_boost(my_asset: Node) -> void:
	my_asset.liquidity_score += 15
	my_asset.volatility_score += 6
	my_asset.risk_score += 3
	my_asset.clamp_scores()

func supply_burn(my_asset: Node, burn_percent: float = 2.0) -> void:
	var burn_amount = int(my_asset.supply_total * (burn_percent / 100.0))
	burn_amount = max(burn_amount, 1)

	my_asset.supply_total = max(my_asset.supply_total - burn_amount, 1)

	my_asset.hype_score += 6
	my_asset.volatility_score += 4
	my_asset.quality_score += 2
	my_asset.clamp_scores()

func marketing_push(my_asset: Node) -> void:
	my_asset.hype_score += 18
	my_asset.volatility_score += 10
	my_asset.risk_score += 5
	my_asset.clamp_scores()

func stability_shield(my_asset: Node) -> void:
	my_asset.volatility_score -= 16
	my_asset.hype_score -= 6
	my_asset.liquidity_score += 4
	my_asset.clamp_scores()
