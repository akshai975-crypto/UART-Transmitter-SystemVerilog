# UART Transmitter using SystemVerilog

## Overview

This project implements a UART (Universal Asynchronous Receiver/Transmitter) Transmitter using SystemVerilog.

The design converts 8-bit parallel data into serial data and transmits it using the UART communication protocol. A self-checking testbench is used to verify the transmitted data.

## Features

- 8-bit parallel-to-serial data transmission
- Configurable clock frequency
- Configurable baud rate
- Finite State Machine (FSM) based design
- Active-low asynchronous reset
- Busy and transmission-done status signals
- Self-checking SystemVerilog testbench
- Waveform generation using VCD file

## Design Specifications

| Parameter | Value |
|---|---|
| Clock Frequency | 10 MHz |
| Baud Rate | 1 Mbps |
| Data Width | 8 bits |
| Start Bit | 1 bit (LOW) |
| Stop Bit | 1 bit (HIGH) |
| Parity | None |

## UART Frame Format

Each transmitted frame consists of:

1. Start Bit – Logic LOW
2. Data Bits – 8 bits (LSB first)
3. Stop Bit – Logic HIGH

## FSM Architecture

The transmitter uses four states:

- **IDLE:** Waits for a transmission request.
- **START:** Sends the start bit.
- **DATA:** Transmits 8 data bits, starting from the LSB.
- **STOP:** Sends the stop bit and completes transmission.

## Module Inputs and Outputs

| Signal | Direction | Description |
|---|---|---|
| clk | Input | System clock |
| rst_n | Input | Active-low reset |
| tx_start | Input | Starts transmission |
| tx_data | Input | 8-bit input data |
| tx | Output | Serial transmission output |
| tx_busy | Output | Indicates transmission in progress |
| tx_done | Output | Indicates transmission completion |

## Testbench Verification

The testbench verifies the UART transmitter by sending three test patterns:

| Test Case | Input Data |
|---|---|
| 1 | 0xA5 |
| 2 | 0x3C |
| 3 | 0xFF |

The serial output is sampled and compared against the original input data.

## Expected Output

```text
[TB] Sending Data Byte: 0xA5
[SUCCESS] Transmitted: 0xA5 | Received: 0xA5

[TB] Sending Data Byte: 0x3C
[SUCCESS] Transmitted: 0x3C | Received: 0x3C

[TB] Sending Data Byte: 0xFF
[SUCCESS] Transmitted: 0xFF | Received: 0xFF

===== ALL TESTS COMPLETED SUCCESSFULLY =====
```

## Simulation

You can simulate the project using ModelSim, QuestaSim, or Icarus Verilog.

### Using Icarus Verilog

Compile:

```bash
iverilog -g2012 -o uart_sim uart_tx.sv tb_uart_tx.sv
```

Run:

```bash
vvp uart_sim
```

View the waveform using GTKWave:

```bash
gtkwave dump.vcd
```

## Applications

- Serial communication systems
- Embedded systems
- FPGA-based communication interfaces
- Microcontroller communication
- Digital hardware design and verification

## Technologies Used

- SystemVerilog
- RTL Design
- Finite State Machine
- Digital Electronics
- Simulation and Verification

## Author

**Akshai Bharath T A**

GitHub: [akshai975-crypto](https://github.com/akshai975-crypto)

---

If you find this project useful, consider giving the repository a star!