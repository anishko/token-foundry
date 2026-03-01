# Token Foundry - Backtest Panel
# Version by Anish Konduri

extends Control

@onready var days_spin = $BacktestBox/Row/DaysSpin
@onready var btn_run = $BacktestBox/Row/BtnRun
@onready var chart_box = $BacktestBox/ChartBox
@onready var status_label = $BacktestBox/BacktestStatus

func _ready() -> void:
	# make the run button visible
	btn_run.text = "Run Backtest"
	btn_run.custom_minimum_size = Vector2(200, 44)

	# make days spin reasonable
	days_spin.min_value = 10
	days_spin.max_value = 365
	days_spin.step = 10
	if days_spin.value < 10:
		days_spin.value = 60

	btn_run.pressed.connect(_on_run_pressed)
	refresh_view()

func _get_main():
	return get_tree().current_scene

func _on_run_pressed() -> void:
	var main = _get_main()
	var my_asset = main.my_asset
	var my_backtester = main.my_backtester

	my_backtester.run_simulation(my_asset, int(days_spin.value))

	# push prices into chart
	chart_box.call("set_prices", my_asset.history_prices)

	var last_price = my_asset.history_prices[my_asset.history_prices.size() - 1]
	status_label.text = "Ran %d days. End price: %.2f" % [int(days_spin.value), last_price]

func refresh_view() -> void:
	var main = _get_main()
	var my_asset = main.my_asset

	if my_asset.history_prices.size() > 1:
		chart_box.call("set_prices", my_asset.history_prices)
		var last_price = my_asset.history_prices[my_asset.history_prices.size() - 1]
		status_label.text = "Last run end price: %.2f" % last_price
	else:
		status_label.text = "No backtest yet. Press Run Backtest."
