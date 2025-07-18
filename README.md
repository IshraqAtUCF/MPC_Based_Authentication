# Secure Authentication for Chiplet-Based SiP

## Overview

**AuthenTree** is a scalable, distributed authentication framework designed for heterogeneous System-in-Package (SiP) platforms. Building upon the core ideas of **SAFE-SiP**, AuthenTree eliminates centralized trust anchors, minimizes area and power overhead, and delivers robust security using modern cryptographic primitives. This repository provides the Verilog RTL implementation of our optimized SHA-256 core, which forms the basis of the AuthenTree protocol.

- **SAFE-SiP**: Introduces signature-based chiplet authentication, leveraging cryptographic garbling and MPC for robust SiP integrity.
- **AuthenTree**: Extends SAFE-SiP with a decentralized, tree-based protocol using SHA-256 and threshold secret sharing, enabling parallel, lightweight authentication for next-generation chiplet systems.

## Features

- [x] Synthesizable SHA-256 RTL core (`src/sha256.v`)
- [ ] AuthenTree threshold/MPC protocol RTL (coming soon)
- [ ] Example testbenches and integration scripts

## Getting Started

1. **Clone the repository:**
   ```
   git clone https://github.com/yourusername/MPC_Based_Authentication.git
   cd MPC_Based_Authentication
   ```

2. **Synthesize for ASIC/FPGA:**

Compatible with Synopsys Design Compiler and Xilinx Vivado.

See source files for module port descriptions.

### AuthenTree at a Glance

Scalable: Tree-based, decentralized protocol for large heterogeneous systems.

Parallelizable: Lightweight, one-time authentication; minimizes bottlenecks.

Low Overhead: Area and power impact is orders of magnitude smaller than recent alternatives.

Robust: Sensitive to tampering, replay, and DoS attacks.

### Key Tables

#### Design Area Overhead of AuthenTree

| Design   | Design Area (μm²) | AuthenTree Area (μm²) | Overhead (%) |
|----------|-------------------|-----------------------|--------------|
| CVA6     |   345,755         | 6,988.20              | 2.02         |
| NVDLA    |   541,552         | 7,192.12              | 1.33         |
| RISC-V   | 1,309,680         | 7,063.03              | 0.54         |
| Ariane   | 1,431,536         | 7,000.50              | 0.49         |
| OR1200   | 1,488,384         | 7,108.00              | 0.48         |

#### Area Comparison with Recent Works

| Work                        | LUT Resource | FF    | Area (mm²)   |
|-----------------------------|-------------|-------|--------------|
| SECT-HI                     | --          | --    | 5.11         |
| PQC-HI (Kyber+Dilithium)    | 76,999      | 49,993| --           |
| PQC-HI (Kyber only)         | 1,842       | 1,634 | --           |
| SAFE-SiP (κ=64)             | --          | --    | 0.0996       |
| **AuthenTree**              | **1,740**   | **1054** | **0.0071** |

#### Authentication Latency Comparison

| Work         | Reported Latency  | Notes                     |
|--------------|-------------------|---------------------------|
| SECT-HI      | 280 ms            | Serialized                |
| PQC-HI       | 1–10 ms           | PQC operations            |
| SAFE-SiP     | ~1 μs             | Parallelizable            |
| **AuthenTree** | <1 μs           | One-time, parallelizable  |

#### Power Overhead Analysis for AuthenTree

| Design  | Baseline Power (mW) | AuthenTree Power (mW) | Overhead (%) |
|---------|---------------------|-----------------------|--------------|
| CVA6    | 12.896              | 0.2357                | 1.83         |
| NVDLA   | 185.140             | 0.2394                | 0.13         |
| RISC-V  | 59.164              | 0.2518                | 0.43         |
| Ariane  | 94.157              | 0.2463                | 0.26         |
| OR1200  | 106.610             | 0.2485                | 0.23         |


## Citation
If you use this work in academic publications, please cite the original SAFE-SiP paper:

```
@inproceedings{tashdid2025safe,
author = {Tashdid, Ishraq and Farheen, Tasnuva and Rahman, Sazadur},
title = {SAFE-SiP: Secure Authentication Framework for System-in-Package Using Multi-party Computation},
year = {2025},
isbn = {9798400714962},
publisher = {Association for Computing Machinery},
address = {New York, NY, USA},
url = {https://doi.org/10.1145/3716368.3735248},
doi = {10.1145/3716368.3735248},
booktitle = {Proceedings of the Great Lakes Symposium on VLSI 2025},
pages = {391–396},
series = {GLSVLSI '25}
}
```

## License

This repository is released under the [MIT License](https://opensource.org/licenses/MIT).

## Contact

For questions, bug reports, or collaboration, contact [Ishraq Tashdid](mailto:tashdid.ishraq@gmail.com).
