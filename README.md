

# 7-Tap Symmetric Pipelined FIR Filter using Verilog HDL

## Project Overview

Digital Signal Processing (DSP) has become an integral part of modern electronic systems, including communication networks, multimedia devices, biomedical equipment, radar systems, image processing applications, and industrial automation. One of the fundamental operations in DSP is filtering, which is used to remove unwanted noise, improve signal quality, and extract useful information from signals.

This project presents the design and simulation of a **7-Tap Symmetric Pipelined Finite Impulse Response (FIR) Filter** using **Verilog HDL**. The filter is implemented using symmetric coefficients to reduce hardware complexity and pipelining techniques to improve processing speed and throughput.

The proposed architecture minimizes the number of multipliers by exploiting coefficient symmetry, thereby reducing hardware area and power consumption. Pipeline registers are inserted between computational stages to reduce the critical path delay and enable operation at higher clock frequencies.

The complete design was modeled using Verilog HDL and functionally verified using the Xilinx Vivado Design Suite. Simulation results demonstrate that the filter operates correctly and produces outputs that match theoretical calculations.

---

# Introduction

Digital filters are mathematical systems that process discrete-time signals to modify their characteristics. They are widely used to remove noise, smooth signals, and shape frequency responses in various engineering applications.

Digital filters are broadly classified into two categories:

## 1. Finite Impulse Response (FIR) Filters

FIR filters have a finite-duration impulse response because the output eventually becomes zero after a finite number of input samples.

Characteristics of FIR filters:

* Always stable
* Linear phase response
* Simple hardware implementation
* No feedback path
* Suitable for FPGA and ASIC implementation

## 2. Infinite Impulse Response (IIR) Filters

IIR filters contain feedback elements, causing the impulse response to continue indefinitely.

Characteristics:

* Requires fewer coefficients
* More computationally efficient
* Can become unstable
* More complex hardware implementation

Because of their guaranteed stability and ease of hardware implementation, FIR filters are widely preferred for VLSI and FPGA applications.

---

# What is a 7-Tap FIR Filter?

The term "tap" refers to one delayed version of the input signal.

A 7-tap FIR filter uses:

* Current input sample
* Six previous input samples

to compute the output.

The general FIR filter equation is

[
y[n]=\sum_{k=0}^{N-1} h[k]x[n-k]
]

where

* (y[n]) = output signal
* (x[n-k]) = delayed input samples
* (h[k]) = filter coefficients
* (N) = number of taps

For this project,

```
N = 7
```

The filter coefficients are

```
h[n] = [1 2 3 4 3 2 1]
```

---

# Project Objectives

The primary objective of this project is to design and simulate a hardware-efficient FIR filter architecture suitable for high-speed digital signal processing applications.

The specific objectives are:

## • Design a 7-Tap FIR Filter

Implement a seven-tap FIR filter using Verilog HDL.

---

## • Utilize Symmetric Coefficients

Exploit coefficient symmetry to reduce the number of multipliers required in the architecture.

---

## • Reduce Hardware Complexity

Minimize arithmetic operations to reduce area and power consumption.

---

## • Introduce Pipelining

Divide computations into multiple stages using pipeline registers to improve throughput and operating frequency.

---

## • Functional Verification

Verify the correctness of the design using simulation waveforms and console outputs in Vivado.

---

## • Compare Theory and Simulation

Ensure that practical simulation results match theoretical FIR calculations.

---

## • Understand DSP Hardware Design

Study practical FIR filter implementation techniques used in FPGA and ASIC systems.

---

# Design Specifications

| Parameter       | Value               |
| --------------- | ------------------- |
| Filter Type     | FIR                 |
| Number of Taps  | 7                   |
| Architecture    | Symmetric Pipelined |
| HDL             | Verilog             |
| Input Width     | 8-bit Signed        |
| Output Width    | 32-bit Signed       |
| Simulation Tool | Xilinx Vivado       |
| Coefficients    | [1 2 3 4 3 2 1]     |
| Pipeline Stages | 4                   |

---

# Advantages of the Proposed Design

The proposed architecture offers several advantages over a conventional FIR implementation.

### Symmetry

* Reduces multiplier count.
* Decreases hardware area.
* Reduces power consumption.

### Pipelining

* Reduces critical path delay.
* Improves operating frequency.
* Increases throughput.
* Enhances timing performance.

### Verilog HDL Implementation

* Synthesizable design.
* Suitable for FPGA implementation.
* Portable across different hardware platforms.

---

## GitHub Project Structure

```
7-Tap-Symmetric-Pipelined-FIR-Filter

rtl/
    symmetric_fir_pipeline.v

tb/
    tb_symmetric_fir.v

README.md
```

---

## Tools Used

### Xilinx Vivado Design Suite

Used for RTL simulation and functional verification.

### Verilog HDL

Used to model and implement the FIR filter architecture.

### MATLAB

Used for signal analysis and result verification.

# Theoretical Background

## Digital Filters

Digital filters are systems used to process discrete-time signals by enhancing desired frequency components and suppressing unwanted noise or interference. They are extensively used in communication systems, audio processing, biomedical instrumentation, radar systems, image processing, and industrial control applications.

Based on their impulse response characteristics, digital filters are classified into two categories:

### Finite Impulse Response (FIR) Filters

FIR filters have a finite-duration impulse response because the output depends only on the present and previous input samples. Since no feedback path exists, FIR filters are inherently stable and easy to implement in digital hardware.

Advantages of FIR filters:

* Guaranteed stability
* Linear phase response
* Simple hardware realization
* No feedback loops
* Suitable for FPGA and ASIC implementations

---

# FIR Filter Principle

An FIR filter performs a weighted summation of present and past input samples.

The general FIR filter equation is

[
y[n]=\sum_{k=0}^{N-1}h[k]x[n-k]
]

where

| Symbol   | Description                       |
| -------- | --------------------------------- |
| (y[n])   | Output signal                     |
| (x[n-k]) | Present and delayed input samples |
| (h[k])   | Filter coefficients               |
| (N)      | Number of taps                    |

For an N-tap filter,

* N multipliers are required.
* N delayed samples are stored.
* Products are accumulated to generate the output.

---

# 7-Tap FIR Filter

The proposed design implements a 7-tap FIR filter.

The coefficient set is

```
h[n]=[1 2 3 4 3 2 1]
```

Since

```
h[0]=h[6]
h[1]=h[5]
h[2]=h[4]
```

the coefficients exhibit symmetry.

Mathematically,

[
h[k]=h[N-1-k]
]

This property is exploited to reduce hardware complexity.

---

# Conventional FIR Implementation

Without optimization, the FIR output equation becomes

[
y[n]=x_0+2x_1+3x_2+4x_3+3x_4+2x_5+x_6
]

where

```
x0 = current input

x1 = first delayed sample

x2 = second delayed sample

...

x6 = sixth delayed sample
```

A conventional implementation requires

* 7 multipliers
* 6 delay elements
* Multiple adders

This increases hardware area and power consumption.

---

# Symmetric FIR Optimization

Since the coefficients are symmetric,

```
1 = 1

2 = 2

3 = 3
```

corresponding input samples can be grouped together.

Instead of

```
x0×1 + x6×1
```

we compute

```
(x0+x6)×1
```

Similarly,

```
x1×2 + x5×2

=(x1+x5)×2
```

and

```
x2×3 + x4×3

=(x2+x4)×3
```

The center coefficient remains

```
x3×4
```

Therefore,

[
y[n]=(x_0+x_6)+2(x_1+x_5)+3(x_2+x_4)+4x_3
]

---

# Hardware Reduction

## Conventional FIR

```
7 Multipliers

6 Delay Registers

Adder Network
```

## Symmetric FIR

```
4 Multipliers

6 Delay Registers

Symmetric Adders

Accumulator
```

### Multiplier Reduction

```
Conventional : 7

Symmetric    : 4
```

Reduction:

```
7−4=3 multipliers
```

Percentage reduction:

[
\frac{3}{7}\times100
====================

42.86%
]

Thus,

* Hardware area decreases.
* Power consumption decreases.
* Computational complexity decreases.

---

# Step-by-Step FIR Calculation

Assume the input sequence

```
1 2 3 4 5 6 7
```

and

```
h=[1 2 3 4 3 2 1]
```

Output:

```
y[n]

=
1×1

+2×2

+3×3

+4×4

+5×3

+6×2

+7×1
```

Calculating,

```
1

+4

+9

+16

+15

+12

+7
```

Therefore,

```
y[n]=64
```

This matches the FIR convolution operation.

---

# Steady-State Analysis

During simulation,

the input eventually becomes constant.

```
x[n]=10
```

The coefficient sum is

```
1+2+3+4+3+2+1
```

Calculating,

```
3

5

8

12

15

17

18?
```

Actually,

```
1+2=3

3+3=6

6+4=10

10+3=13

13+2=15

15+1=16
```

Thus,

```
Coefficient Sum=16
```

The steady-state output becomes

[
y[n]=10\times16
]

Therefore,

```
y[n]=160
```

This theoretical value matches the simulation output obtained in Vivado.

---

# Advantages of Symmetric FIR Filters

The symmetric FIR architecture offers several advantages:

### Reduced Hardware

Fewer multipliers are required.

---

### Lower Power Consumption

Reduced arithmetic operations decrease switching activity.

---

### Improved Area Efficiency

Smaller hardware footprint for FPGA and ASIC implementation.

---

### Faster Operation

Fewer arithmetic operations improve computational efficiency.

---

### Easy Hardware Implementation

Symmetric structures are widely used in DSP hardware accelerators.

# Pipeline Architecture and RTL Design

## Pipeline Architecture

The proposed FIR filter employs a pipelined architecture to improve throughput and reduce the critical path delay. Instead of performing all computations in a single clock cycle, the operations are divided into multiple stages separated by registers.

The architecture consists of four major stages:

```
                Input Sample
                     |
                     V
          +-------------------+
          | Stage 1           |
          | Delay Registers   |
          +-------------------+
                     |
                     V
          +-------------------+
          | Stage 2           |
          | Symmetric Addition|
          +-------------------+
                     |
                     V
          +-------------------+
          | Stage 3           |
          | Multiplication    |
          +-------------------+
                     |
                     V
          +-------------------+
          | Stage 4           |
          | Accumulation      |
          +-------------------+
                     |
                     V
                 Filter Output
```

Pipeline registers isolate each computational stage, enabling the circuit to operate at higher clock frequencies.

---

# Stage 1 : Delay Line

The first stage stores present and previous input samples.

Seven registers are used:

```
x0
x1
x2
x3
x4
x5
x6
```

At every positive edge of the clock,

```
x6 <= x5

x5 <= x4

x4 <= x3

x3 <= x2

x2 <= x1

x1 <= x0

x0 <= x_in
```

This creates delayed versions of the input signal required for FIR convolution.

---

## Example

Suppose the inputs are

```
1 2 3 4 5 6 7
```

After several clock cycles,

| Register | Value |
| -------- | ----- |
| x0       | 7     |
| x1       | 6     |
| x2       | 5     |
| x3       | 4     |
| x4       | 3     |
| x5       | 2     |
| x6       | 1     |

These delayed samples are passed to the next stage.

---

# Stage 2 : Symmetric Pair Addition

The symmetric coefficients allow corresponding delayed samples to be added before multiplication.

The following operations are performed:

```
s0 = x0 + x6

s1 = x1 + x5

s2 = x2 + x4

s3 = x3
```

For the above example,

```
s0 = 7+1=8

s1 = 6+2=8

s2 = 5+3=8

s3 = 4
```

The outputs become

| Signal | Value |
| ------ | ----- |
| s0     | 8     |
| s1     | 8     |
| s2     | 8     |
| s3     | 4     |

This stage reduces the multiplier requirement.

---

# Stage 3 : Multiplication

Each symmetric sum is multiplied by its corresponding coefficient.

The coefficients are

```
h0=1

h1=2

h2=3

h3=4
```

The operations are

```
m0=s0×1

m1=s1×2

m2=s2×3

m3=s3×4
```

Substituting the values,

```
m0=8

m1=16

m2=24

m3=16
```

---

# Stage 4 : Final Accumulation

The multiplication outputs are added together.

```
y_out=m0+m1+m2+m3
```

Substituting,

```
y_out=8+16+24+16
```

Therefore,

```
y_out=64
```

This matches the direct FIR calculation.

---

# Register Transfer Level (RTL) Operation

The Verilog implementation follows the Register Transfer Level design methodology.

RTL divides the hardware into sequential and combinational operations.

## Sequential Blocks

Triggered by

```
always @(posedge clk)
```

Used for

* Delay registers
* Pipeline registers
* Output register

---

## Reset Logic

When

```
rst=1
```

All registers become zero.

```
x0=x1=x2=x3=x4=x5=x6=0

s0=s1=s2=s3=0

m0=m1=m2=m3=0

y_out=0
```

This guarantees deterministic startup.

---

# Pipeline Timing

Suppose the input sequence is

```
1

2

3

4

...
```

Clock 1:

```
Input stored.
```

Clock 2:

```
Delayed samples updated.
```

Clock 3:

```
Symmetric sums generated.
```

Clock 4:

```
Multiplication completed.
```

Clock 5:

```
Accumulation completed.

Output available.
```

Although the first output experiences latency, the pipeline allows a new input to be processed every clock cycle.

---

# Pipeline Latency

Latency is the number of clock cycles required for an input sample to propagate through the pipeline.

For this design,

```
Stage 1

↓

Stage 2

↓

Stage 3

↓

Stage 4
```

Pipeline latency is approximately

```
4 clock cycles
```

---

# Throughput Improvement

Without pipelining,

```
One complete FIR operation
must finish before the next begins.
```

With pipelining,

```
Multiple input samples are processed simultaneously.
```

Example:

```
Clock 1

Input 1 : Delay

Clock 2

Input 1 : Addition

Input 2 : Delay

Clock 3

Input 1 : Multiplication

Input 2 : Addition

Input 3 : Delay

Clock 4

Input 1 : Accumulation

Input 2 : Multiplication

Input 3 : Addition

Input 4 : Delay
```

Thus,

multiple samples are processed concurrently.

---

# Advantages of the RTL Architecture

## Hardware Efficiency

Symmetry reduces multiplier count.

---

## High Speed

Pipeline registers reduce critical path delay.

---

## Lower Power Consumption

Reduced arithmetic operations minimize switching activity.

---

## FPGA Friendly

The architecture maps efficiently onto FPGA resources.

---

## Scalable Design

The same approach can be extended to larger FIR filters.

---

# RTL Design Summary

The proposed RTL architecture consists of:

| Stage   | Operation               |
| ------- | ----------------------- |
| Stage 1 | Delay Registers         |
| Stage 2 | Symmetric Pair Addition |
| Stage 3 | Multiplication          |
| Stage 4 | Final Accumulation      |

The architecture:

* Stores delayed input samples.
* Exploits coefficient symmetry.
* Reduces multiplier count from 7 to 4.
* Uses pipelining for higher throughput.
* Produces outputs matching theoretical FIR calculations.
* Is fully synthesizable and suitable for FPGA implementation.

# Verilog HDL Implementation

## Introduction

Hardware Description Languages (HDLs) are used to model and simulate digital systems before hardware implementation. In this project, Verilog HDL is used to design a 7-Tap Symmetric Pipelined FIR Filter.

The entire architecture is divided into four pipeline stages:

1. Delay Line
2. Symmetric Pair Addition
3. Multiplication
4. Final Accumulation

Each stage is synchronized using the positive edge of the clock signal.

---

# Top Module

The top module of the design is

```verilog
module symmetric_fir_pipeline
```

The module consists of three ports.

## Inputs

### Clock Signal

```verilog
input clk;
```

The clock synchronizes all pipeline operations.

Every positive edge triggers:

* Register shifting
* Symmetric additions
* Multiplications
* Output accumulation

---

### Reset Signal

```verilog
input rst;
```

The reset initializes all registers to zero.

When

```
rst=1
```

the filter starts from a known initial state.

---

### Input Data

```verilog
input signed [7:0] x_in;
```

The input sample is an 8-bit signed number.

Signed arithmetic allows both positive and negative signal values.

---

## Output

```verilog
output reg signed [31:0] y_out;
```

The output is a 32-bit signed register.

The larger width prevents overflow during multiplication and accumulation.

---

# Stage 1 : Delay Line Implementation

The first stage stores present and previous samples.

```verilog
reg signed [7:0]

x0,x1,x2,x3,x4,x5,x6;
```

Each register represents one tap.

```
x0

↓

x1

↓

x2

↓

x3

↓

x4

↓

x5

↓

x6
```

---

## Delay Register Operation

At every clock edge,

```verilog
x6<=x5;

x5<=x4;

x4<=x3;

x3<=x2;

x2<=x1;

x1<=x0;

x0<=x_in;
```

This creates delayed versions of the input signal.

---

## Example

Suppose inputs are

```
1

2

3

4

5

6

7
```

After seven clock cycles,

| Register | Value |
| -------- | ----- |
| x0       | 7     |
| x1       | 6     |
| x2       | 5     |
| x3       | 4     |
| x4       | 3     |
| x5       | 2     |
| x6       | 1     |

---

# Stage 2 : Symmetric Pair Addition

The second stage exploits coefficient symmetry.

Registers:

```verilog
reg signed [15:0]

s0,s1,s2,s3;
```

Operations:

```verilog
s0=x0+x6;

s1=x1+x5;

s2=x2+x4;

s3=x3;
```

This reduces the multiplier count.

---

## Example

Using

```
7 6 5 4 3 2 1
```

we obtain

```
s0=8

s1=8

s2=8

s3=4
```

---

# Stage 3 : Multiplication

The FIR coefficients are declared as parameters.

```verilog
parameter h0=1;

parameter h1=2;

parameter h2=3;

parameter h3=4;
```

Multiplier registers:

```verilog
reg signed [31:0]

m0,m1,m2,m3;
```

Operations:

```verilog
m0=s0*h0;

m1=s1*h1;

m2=s2*h2;

m3=s3*h3;
```

---

## Example

```
s0=8

s1=8

s2=8

s3=4
```

Then,

```
m0=8

m1=16

m2=24

m3=16
```

---

# Stage 4 : Final Accumulation

The final stage computes

```verilog
y_out=m0+m1+m2+m3;
```

Substituting,

```
8+16+24+16
```

Therefore,

```
y_out=64
```

which matches the theoretical FIR calculation.

---

# Reset Operation

During reset,

```verilog
if(rst)
```

all registers become zero.

```
Delay Registers

↓

Symmetric Registers

↓

Multiplier Registers

↓

Output Register
```

This prevents undefined outputs.

---

# Pipeline Registers

Pipeline registers separate each computational stage.

Benefits:

* Reduced propagation delay
* Higher operating frequency
* Improved throughput
* Better timing performance

---

# Testbench Design

A separate Verilog testbench verifies the functionality of the FIR filter.

Module:

```verilog
module tb_symmetric_fir;
```

The testbench generates:

* Clock
* Reset
* Input sequence

and observes the output.

---

# Clock Generation

The clock toggles every

```
5 ns
```

using

```verilog
always #5 clk=~clk;
```

Clock period:

```
10 ns
```

---

# Reset Sequence

Initially,

```
rst=1;
```

All registers are cleared.

After

```
12 ns
```

```
rst=0;
```

Normal operation begins.

---

# Input Stimulus

The applied sequence is

```
1

2

3

4

5

6

7

8

9

10
```

After reaching

```
10
```

the input remains constant.

This helps observe steady-state behavior.

---

# Output Monitoring

The statement

```verilog
$display(
"time=%0t x=%0d y=%0d",
$time,
x_in,
y_out
);
```

prints

* Simulation time
* Current input
* FIR output

This helps verify the filter operation.

---

# Simulation Methodology

The simulation follows these steps:

### Step 1

Initialize the system.

```
rst=1
```

---

### Step 2

Release reset.

```
rst=0
```

---

### Step 3

Apply ramp input sequence.

```
1→10
```

---

### Step 4

Observe delayed samples.

---

### Step 5

Verify symmetric additions.

---

### Step 6

Verify multiplication outputs.

---

### Step 7

Verify accumulated output.

---

### Step 8

Check steady-state response.

```
160
```

---

# Verification

The design was verified by comparing:

## Mathematical Analysis

Manual FIR calculations.

## Verilog Simulation

Vivado simulation output.

## TCL Console Output

Printed simulation values.

## Waveform Observation

Signal transitions over time.

All methods produced matching results.

---

# Advantages of the Verilog Implementation

✅ Modular architecture.

✅ Fully synthesizable RTL.

✅ Efficient hardware utilization.

✅ Reduced multiplier count.

✅ Pipeline-friendly design.

✅ Suitable for FPGA implementation.

---

# Verilog Implementation Summary

The RTL implementation successfully demonstrates:

* Delay-line realization.
* Symmetric coefficient optimization.
* Hardware-efficient multiplication.
* Pipeline-based processing.
* Correct FIR convolution.
* Functional verification through simulation.

The design accurately implements a 7-Tap Symmetric Pipelined FIR Filter and produces outputs consistent with theoretical DSP analysis.

---

# Simulation Results and Waveform Analysis

## Introduction

After completing the RTL design and testbench development, the proposed 7-Tap Symmetric Pipelined FIR Filter was simulated using the Xilinx Vivado Design Suite. The objective of the simulation was to verify the correctness of the FIR filter operation and compare the obtained outputs with theoretical calculations.

Functional verification was carried out by applying a sequence of input samples to the filter and observing the corresponding output response through simulation waveforms and TCL console outputs.

The simulation confirmed that the proposed architecture correctly implements the FIR convolution operation while exploiting symmetry and pipelining techniques.

---

# Simulation Setup

The FIR filter was verified using a dedicated Verilog testbench.

## Clock Signal

Clock period:

```
10 ns
```

Clock generation:

```
always #5 clk = ~clk;
```

This provides a stable clock for all pipeline operations.

---

## Reset Signal

Initially,

```
rst = 1
```

All registers are initialized to zero.

After

```
12 ns
```

the reset signal is deactivated.

```
rst = 0
```

Normal FIR operation begins.

---

## Input Sequence

The following ramp sequence is applied:

```
1

2

3

4

5

6

7

8

9

10
```

After reaching

```
10
```

the input remains constant.

Keeping the input constant helps observe the steady-state response of the FIR filter.

---

# Simulation Process

The filter operation proceeds through several stages.

## Step 1

Reset clears all registers.

```
x0=x1=x2=x3=x4=x5=x6=0

s0=s1=s2=s3=0

m0=m1=m2=m3=0

y_out=0
```

---

## Step 2

Input samples enter the delay line.

```
x0

↓

x1

↓

x2

↓

...

↓

x6
```

---

## Step 3

Symmetric pairs are formed.

```
s0=x0+x6

s1=x1+x5

s2=x2+x4

s3=x3
```

---

## Step 4

The symmetric sums are multiplied by the FIR coefficients.

```
m0=s0×1

m1=s1×2

m2=s2×3

m3=s3×4
```

---

## Step 5

The multiplication outputs are accumulated.

```
y_out=m0+m1+m2+m3
```

---

## Step 6

The filtered output is generated.

---

# Initial Output Behaviour

Immediately after reset,

```
y_out=0
```

This occurs because all delay registers contain zero values.

Initially,

```
x0=0

x1=0

x2=0

x3=0

x4=0

x5=0

x6=0
```

As new samples enter the delay line,

older samples gradually fill the pipeline.

Consequently,

the FIR output gradually increases.

---

# Pipeline Latency

Since the filter consists of four pipeline stages,

the output does not appear immediately.

The stages are

```
Delay

↓

Addition

↓

Multiplication

↓

Accumulation
```

Each stage requires one clock cycle.

Therefore,

the output experiences pipeline latency before becoming available.

This is a normal characteristic of pipelined architectures.

---

# Waveform Analysis

The simulation waveform verifies the correct operation of the FIR filter.

The waveform demonstrates:

## Delay Operation

Input samples move correctly through the shift registers.

---

## Symmetric Addition

Corresponding delayed samples are paired correctly.

---

## Multiplication

Each symmetric sum is multiplied by its coefficient.

---

## Accumulation

The multiplication outputs are correctly added.

---

## Pipeline Operation

The output appears after the expected pipeline delay.

---

## Steady-State Operation

The output stabilizes after all delay registers are filled.

---

# TCL Console Verification

The TCL console prints

```
time

input

output
```

using

```
$display()
```

This provides a numerical verification of the FIR operation.

The printed values match the expected theoretical outputs.

---

# Mathematical Verification

When

```
x[n]=10
```

the coefficient sum is

```
1+2+3+4+3+2+1
```

Calculating,

```
16
```

Therefore,

```
y[n]=10×16
```

Thus,

```
y[n]=160
```

---

# Steady-State Analysis

Initially,

the delay registers contain zeros.

The output is therefore small.

As more samples enter the filter,

additional delayed samples participate in the convolution operation.

Eventually,

all delay registers contain

```
10
```

The output becomes

```
10+20+30+40+30+20+10
```

Calculating,

```
160
```

The output then remains constant.

This confirms proper FIR filter operation.

---

# Verification Summary

The simulation confirms

✅ Correct delay operation.

✅ Correct symmetric addition.

✅ Correct multiplication.

✅ Correct accumulation.

✅ Proper pipeline behaviour.

✅ Correct steady-state output.

✅ Agreement between theory and simulation.

---

# Applications

The proposed FIR filter architecture can be used in various DSP applications.

## Audio Processing

Noise removal and signal enhancement.

---

## Communication Systems

Channel equalization and signal conditioning.

---

## Biomedical Engineering

ECG and EEG signal processing.

---

## Image Processing

Image smoothing and edge enhancement.

---

## Radar Systems

Target detection and filtering.

---

## FPGA Accelerators

High-speed DSP hardware implementation.

---

# Future Enhancements

Several improvements can be incorporated into the present design.

## Parameterized FIR Filter

Generalize the design for any number of taps.

---

## FPGA Synthesis

Implement the filter on FPGA hardware.

---

## Fixed-Point Optimization

Improve hardware efficiency.

---

## MAC Architecture

Replace separate multipliers and adders with MAC units.

---

## Low-Power Design

Apply clock gating and power optimization techniques.

---

## Adaptive FIR Filter

Implement LMS or RLS adaptive algorithms.

---

# Conclusion

A 7-Tap Symmetric Pipelined FIR Filter was successfully designed and simulated using Verilog HDL.

The implementation utilized coefficient symmetry to reduce the number of multipliers from seven to four, thereby decreasing hardware complexity and improving area efficiency.

Pipeline registers were introduced to divide the FIR computation into multiple stages, reducing the critical path delay and increasing throughput.

The design was functionally verified using Xilinx Vivado Design Suite. Simulation waveforms and TCL console outputs matched the theoretical FIR calculations.

For a constant input value of 10, the filter achieved a steady-state output of 160, confirming the correctness of the FIR convolution operation.

The project demonstrates the practical implementation of high-speed, hardware-efficient DSP architectures suitable for FPGA and ASIC applications.

---

# References

1. John G. Proakis and Dimitris G. Manolakis,
   *Digital Signal Processing: Principles, Algorithms, and Applications.*

2. Sanjit K. Mitra,
   *Digital Signal Processing: A Computer-Based Approach.*

3. Samir Palnitkar,
   *Verilog HDL: A Guide to Digital Design and Synthesis.*

4. Uwe Meyer-Baese,
   *Digital Signal Processing with Field Programmable Gate Arrays.*

5. Xilinx,
   *Vivado Design Suite User Guide.*

6. MATLAB Documentation.

7. K. K. Parhi,
   *VLSI Digital Signal Processing Systems: Design and Implementation.*

---

