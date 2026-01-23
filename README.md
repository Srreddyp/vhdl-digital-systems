# VHDL Digital Systems (Vivado Labs)

Collection of **VHDL / Vivado** lab assignments developed for the course **Computer Technology and Organization (UCM)** during **2023–2024**.

The repository groups multiple FPGA-oriented practices (inputs via switches/buttons, outputs via LEDs and 7-segment displays) covering finite-state machines, datapath/control design, comparator networks, and multicycle MIPS modifications.

## Authors

* Alejandro Parreño Minaya — GitHub: `aparreno14`
* Diego Ostos Arellano

## Repository structure

* `Lab Instructions/` — lab statements (standard + advanced/optional)
* `P2/` — Practice 2: Digital lock (FSM)
* `P3/` — Practice 3: Comparator networks (iterative + tree)
* `P4/` — Practice 4: Iterative multiplier (ASM)
* `P5/` — Practice 5: Slot machine (control + datapath)
* `P6/` — Practice 6: Multicycle MIPS (extensions and debugging)

## Labs overview (technical summary)

### P2 — Digital Lock (Finite-State Machine)

Digital lock with key verification and attempt management. Interaction through switches/buttons and status visualization using LEDs and 7-segment displays. The advanced version introduces configurable attempts and LED blinking on lockout.

### P3 — Comparator Networks (Iterative and Tree)

Two architectures (iterative and tree-based) to compute the maximum of a list of signed numbers. Parameterized (power-of-two sizes) using generate constructs. Includes resource/critical path analysis. The advanced option proposes pipelining the tree network to increase maximum frequency and report timing margins (setup/hold).

### P4 — Iterative Multiplier (ASM)

Multiplier based on repeated addition (4-bit operands, 8-bit result), controlled by start/finish signals and displayed on 7-segment outputs. The advanced version reduces iterations by using the smaller operand as the loop counter (register swap) and exposes a “swap/cambio” indicator signal.

### P5 — Slot Machine (Algorithmic System)

System with two modulo-10 counters running at different frequencies, LED sequences (attract mode / win / bad luck), and start/stop control. The advanced version adds a credit system (initial credits, decrement per play, reward on win, saturation, and lock when credits reach zero), showing credits on the most significant display.

### P6 — Multicycle MIPS (CPU Extensions)

Multicycle MIPS baseline (datapath + control FSM) plus modifications such as displaying register contents on 7-segment displays, single-step debug mode (stop at the initial state and show PC bits), and additional instructions (e.g., reading switches, move variants, jump), depending on the lab specification.

## Requirements

* Xilinx Vivado (version compatible with the course/lab environment).
* The FPGA board used in the lab (constraint files are board-specific).

## How to open and run (Vivado)

For each practice folder (`P2`–`P6`):

1. Open Vivado.
2. Open the corresponding project (the `.xpr` file if included).
3. Run simulation (if testbenches are provided).
4. Run Synthesis → Implementation → Generate Bitstream.
5. Program the FPGA and validate behavior using switches/buttons/LEDs/7-segment displays as specified in the lab statement.

## Portfolio notes

* Keep version-controlled artifacts focused on: VHDL sources, constraints (`.xdc`), testbenches, and documentation.
* Ignore generated Vivado output (runs, caches, `.Xil/`, etc.) via `.gitignore`.
* Recommended: add a small `README.md` inside each `P2`…`P6` folder (objective, top entity, I/O mapping, and one screenshot/photo).

## License

MIT — see `LICENSE`.

## Disclaimer

Published for educational and portfolio purposes. If you are currently taking the course, do not reuse this code for graded submissions.
