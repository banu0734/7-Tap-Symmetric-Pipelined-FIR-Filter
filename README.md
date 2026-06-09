
# 7-Tap Symmetric Pipelined FIR Filter using Verilog HDL

## Project Overview

This project implements a high-speed 7-Tap Symmetric Pipelined FIR Filter using Verilog HDL. The filter utilizes coefficient symmetry to reduce the number of multipliers required for computation and employs pipelining to improve throughput and reduce critical path delay.

The design has been simulated and verified using Xilinx Vivado Design Suite.

---

## Features

* 7-Tap FIR Filter
* Symmetric Coefficients
* Four Pipeline Stages
* Reduced Hardware Complexity
* High Throughput
* Verilog HDL Implementation
* Functional Verification in Vivado

---

## Filter Coefficients

```
h[n] = [1 2 3 4 3 2 1]
```

The symmetry property is

```
h[k] = h[N-1-k]
```

which reduces multiplier usage from 7 to 4.

---

## FIR Equation

```
y[n]=(x0+x6)+2(x1+x5)+3(x2+x4)+4(x3)
```

---

## Pipeline Architecture

```
Input
  |
Delay Registers
  |
Symmetric Pair Addition
  |
Coefficient Multiplication
  |
Final Accumulation
  |
Output
```

---

## Simulation Input

```
1 2 3 4 5 6 7 8 9 10
```

After reaching 10, the input remains constant.

Steady State Output:

```
160
```

---

## Tools Used

* Verilog HDL
* Xilinx Vivado
* MATLAB

---

## Applications

* DSP
* Audio Processing
* Biomedical Systems
* Communication Systems
* FPGA Accelerators

---

## Folder Structure

```
rtl/
tb/
waveforms/
docs/
README.md
```

---

## Future Scope

* Parameterized FIR Filter
* FPGA Implementation
* Fixed Point Arithmetic
* MAC Based Architecture

---

## Author

Banushree M

---


These visuals make the repository much more attractive to recruiters. I can also help you create professional architecture diagrams and polish the Verilog code/comments before you publish it.
