# 8-Bit Universal Shift Register in Verilog

A synthesizable **8-bit Universal Shift Register** designed using Verilog HDL.

The design supports four operations: **Hold, Shift Right, Shift Left, and Parallel Load**. The project is verified using a Verilog testbench and can be analyzed using GTKWave.

---

## Features

* Verilog HDL implementation
* 8-bit configurable shift register
* Hold operation
* Shift Right operation
* Shift Left operation
* Parallel Load operation
* Serial input from both directions
* Synchronous operation
* Active-high reset
* Synthesizable RTL
* Verilog testbench
* Icarus Verilog simulation
* GTKWave waveform analysis

---

## Operation Modes

The `mode` input selects the operation.

| `mode`  | Operation     |
| ------- | ------------- |
| `2'b00` | Hold          |
| `2'b01` | Shift Right   |
| `2'b10` | Shift Left    |
| `2'b11` | Parallel Load |

---

## Block Diagram

```text
                    ┌──────────────────┐
parallel_in[7:0] ──►│                  │
                    │                  │
serial_in_left ────►│  8-Bit Universal │───► Q[7:0]
                    │  Shift Register  │
serial_in_right ───►│                  │
                    │                  │
mode[1:0] ─────────►│                  │
                    └────────┬─────────┘
                             │
                            clk
                             │
                            rst
```

---

## Project Structure

```text
shift-register-verilog/
│
├── rtl/
│   └── shift_register.v
│
├── tb/
│   └── shift_register_tb.v
│
├── simulation/
│   └── shift_register.vcd
│
└── README.md
```

---

## Inputs and Outputs

### Inputs

| Signal            | Width | Description                  |
| ----------------- | ----: | ---------------------------- |
| `clk`             |     1 | System clock                 |
| `rst`             |     1 | Active-high reset            |
| `mode`            |     2 | Operation selection          |
| `serial_in_left`  |     1 | Serial input for right shift |
| `serial_in_right` |     1 | Serial input for left shift  |
| `parallel_in`     |     8 | Parallel data input          |

### Output

| Signal | Width | Description               |
| ------ | ----: | ------------------------- |
| `q`    |     8 | Current register contents |

---

## Operation Details

### 1. Hold

```text
mode = 00
```

The register retains its current value.

```text
Q = 10101010

       HOLD

Q = 10101010
```

---

### 2. Shift Right

```text
mode = 01
```

A new bit enters from the MSB side.

Example:

```text
Initial:
10101010

serial_in_left = 1

After shift:
11010101
```

Multiple shifts:

```text
10101010
   ↓
11010101
   ↓
11101010
   ↓
11110101
```

---

### 3. Shift Left

```text
mode = 10
```

A new bit enters from the LSB side.

Example:

```text
Initial:
11110101

serial_in_right = 0

After shift:
11101010
```

Multiple shifts:

```text
11110101
   ↓
11101010
   ↓
11010100
   ↓
10101000
```

---

### 4. Parallel Load

```text
mode = 11
```

All eight bits are loaded simultaneously.

Example:

```text
parallel_in = 10101010

Q = 10101010
```

---

## Reset

When `rst` is HIGH, the register is cleared:

```text
rst = 1

Q = 00000000
```

The reset is synchronous with the rising edge of `clk`.

---

## Simulation

### Required Tools

* Icarus Verilog
* GTKWave

### Compile

From the project root:

```bash
iverilog -o shift_register_sim rtl/shift_register.v tb/shift_register_tb.v
```

### Run

```bash
vvp shift_register_sim
```

### View Waveform

```bash
gtkwave shift_register.vcd
```

---

## Expected Simulation Output

```text
TIME=51 ns  | RESET                | Q = 00000000 | HEX = 0x00
TIME=71 ns  | PARALLEL LOAD        | Q = 10101010 | HEX = 0xaa

TIME=91 ns  | SHIFT RIGHT          | Q = 11010101 | HEX = 0xd5
TIME=111 ns | SHIFT RIGHT          | Q = 11101010 | HEX = 0xea
TIME=131 ns | SHIFT RIGHT          | Q = 11110101 | HEX = 0xf5

TIME=151 ns | SHIFT LEFT           | Q = 11101010 | HEX = 0xea
TIME=171 ns | SHIFT LEFT           | Q = 11010100 | HEX = 0xd4
TIME=191 ns | SHIFT LEFT           | Q = 10101000 | HEX = 0xa8

TIME=211 ns | HOLD                 | Q = 10101000 | HEX = 0xa8
TIME=231 ns | HOLD                 | Q = 10101000 | HEX = 0xa8

----------------------------------------
       SIMULATION COMPLETE
----------------------------------------
```

---

## Waveform Verification

The GTKWave simulation should show:

```text
clk
rst
mode
parallel_in
serial_in_left
serial_in_right
q
```

The `q` output should change only on the active clock edge.

Example sequence:

```text
Parallel Load:
10101010

Shift Right:
11010101
11101010
11110101

Shift Left:
11101010
11010100
10101000

Hold:
10101000
10101000
```

---

## Applications

Shift registers are commonly used in:

* Serial-to-parallel conversion
* Parallel-to-serial conversion
* Data buffering
* Digital communication
* LED control
* Display drivers
* FPGA interfaces
* Digital signal processing
* Data delay circuits
* UART/SPI-related circuits

---

## Learning Outcomes

This project demonstrates:

* Verilog HDL
* RTL design
* Sequential logic
* Flip-flop based storage
* Shift operations
* Parallel data loading
* Serial data handling
* Multiplexer/control logic
* Synchronous reset
* Testbench development
* Digital waveform analysis
* FPGA-oriented design

---

## Future Improvements

Possible extensions include:

* SISO shift register
* SIPO shift register
* PISO shift register
* PIPO shift register
* Configurable register width
* Bidirectional shifting
* Rotate left/right
* Serial output signals
* Clock enable
* FIFO implementation
* FPGA board implementation

---

## Tools Used

| Tool           | Purpose           |
| -------------- | ----------------- |
| Verilog HDL    | RTL Design        |
| Icarus Verilog | Simulation        |
| GTKWave        | Waveform Analysis |
| Git            | Version Control   |
| GitHub         | Project Hosting   |

---
