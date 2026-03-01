# Token Foundry

Token Foundry is a sandbox simulation for designing, refining, and testing digital assets.

The tool lets users create a custom asset, adjust its economic parameters, apply upgrades, and simulate how the asset performs over time using a simple backtesting model.

Built using the Godot Engine and GDScript.

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
