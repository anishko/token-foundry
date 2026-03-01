# Token Foundry

Token Foundry is a sandbox simulation for designing, refining, and testing digital assets.

The tool lets users create a custom asset, adjust its economic parameters, apply upgrades, and simulate how the asset performs over time using a simple backtesting model.

Built using the Godot Engine and GDScript.

<img width="1281" height="314" alt="image" src="https://github.com/user-attachments/assets/d16b0152-96e5-46bf-8f71-830552bcc68c" />
<img width="1278" height="530" alt="image" src="https://github.com/user-attachments/assets/6c570c06-9719-4e32-84d4-8a415a7a8c58" />
<img width="1277" height="408" alt="image" src="https://github.com/user-attachments/assets/f8d3b046-6660-4d83-97a8-96b11c3ccdd3" />

---

## Live Demo

Play the browser version here:

https://anishko.itch.io/godotmintengine

**If you are met with an error within itch.io please run the source code on the latest version of GoDot engine Web)- : https://editor.godotengine.org/releases/latest/ **
---

## Features

### Forge Assets
Create a digital asset and configure its properties.

- Asset name
- Asset type (Token / NFT)
- Total supply
- Base value

The system generates initial statistics such as:

- Quality
- Risk
- Liquidity
- Volatility
- Hype

---

### Refine Assets

Improve the asset using refinement actions:

- Audit → improves quality and reduces risk  
- Liquidity → increases liquidity score  
- Burn 2% → reduces supply and affects price  
- Marketing → increases hype  
- Stability Shield → reduces volatility  

These mechanics simulate common strategies used in real digital asset ecosystems.

---

### Backtesting

The backtester simulates price behavior over a configurable time period.

The simulation uses the asset's statistics to influence price movement, allowing users to experiment with different asset configurations and strategies.

---

## Tech Stack

- Godot Engine 4
- GDScript
- Web export (HTML5 / WebAssembly)

---

## Project Structure

Main.tscn → Main UI scene
main.gd → Core application logic

forge_panel.gd → Asset creation system
refine_panel.gd → Asset refinement logic
backtest_panel.gd → Backtesting simulation
chart_box.gd → Chart rendering

scripts/ → Core simulation logic

project.godot → Godot project configuration


---

## How To Run

### Run in Godot

1. Install Godot 4.x
2. Clone this repository
3. Open the project in Godot
4. Run `Main.tscn`

### Play in Browser

Use the itch.io web version:

https://anishko.itch.io/token

---

## Future Improvements

Possible extensions to the simulation include:

- Real-time chart visualization
- Market sentiment modeling
- Multi-asset portfolio simulation
- More advanced pricing algorithms
- Data export for analysis

---

## Author

Anish Konduri
2026
