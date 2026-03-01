# Token Foundry - Chart Box
# Version by Anish Konduri

extends Control

var prices: Array = []

func _ready() -> void:
	# a little padding so the line doesn't touch edges
	custom_minimum_size = Vector2(0, 260)
	queue_redraw()

# called from backtest_panel.gd
func set_prices(new_prices: Array) -> void:
	prices = new_prices.duplicate()
	queue_redraw()

func _draw() -> void:
	# background box
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.16, 0.16, 0.16, 1.0), true)
	draw_rect(Rect2(Vector2.ZERO, size), Color(0.30, 0.30, 0.30, 1.0), false, 2.0)

	# no data yet
	if prices == null or prices.size() < 2:
		_draw_text("Run backtest to see chart.")
		return

	# find min/max
	var min_p = float(prices[0])
	var max_p = float(prices[0])

	for p in prices:
		var fp = float(p)
		if fp < min_p:
			min_p = fp
		if fp > max_p:
			max_p = fp

	# avoid divide by 0
	if abs(max_p - min_p) < 0.000001:
		max_p = min_p + 1.0

	# plot area padding
	var pad = 14.0
	var w = max(size.x - pad * 2.0, 1.0)
	var h = max(size.y - pad * 2.0, 1.0)

	# draw grid lines (simple)
	var grid_lines = 4
	for i in range(1, grid_lines + 1):
		var gy = pad + (h * float(i) / float(grid_lines + 1))
		draw_line(Vector2(pad, gy), Vector2(pad + w, gy), Color(0.22, 0.22, 0.22, 1.0), 1.0)

	# draw price line
	var n = prices.size()
	var prev = Vector2.ZERO

	for i in range(n):
		var t = float(i) / float(n - 1)
		var x = pad + t * w

		var val = float(prices[i])
		var norm = (val - min_p) / (max_p - min_p)
		var y = pad + (1.0 - norm) * h

		var pt = Vector2(x, y)

		if i > 0:
			draw_line(prev, pt, Color(0.85, 0.85, 0.95, 1.0), 2.0)

		prev = pt

	# min/max labels
	_draw_text("min %.2f  max %.2f" % [min_p, max_p], Vector2(10, 10))

func _draw_text(t: String, pos: Vector2 = Vector2(10, 22)) -> void:
	var font = get_theme_default_font()
	if font == null:
		return
	draw_string(font, pos + Vector2(0, 14), t, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color(1, 1, 1, 1))
