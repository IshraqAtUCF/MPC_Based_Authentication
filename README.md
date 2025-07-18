# AuthenTree & SAFE-SiP: Secure Authentication for Chiplet-Based SiP

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
   git clone https://github.com/yourusername/authentree.git
   cd authentree
   ```

2. **Synthesize for ASIC/FPGA:**

Compatible with Synopsys Design Compiler and Xilinx Vivado.

See source files for module port descriptions.

### AuthenTree at a Glance

Scalable: Tree-based, decentralized protocol for large heterogeneous systems.

Parallelizable: Lightweight, one-time authentication; minimizes bottlenecks.

Low Overhead: Area and power impact is orders of magnitude smaller than recent alternatives.

Robust: Sensitive to tampering, replay, and DoS attacks.

## Citation
If you use this work in academic publications, please cite the original SAFE-SiP paper:

```
@inproceedings{10.1145/3716368.3735248,
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
