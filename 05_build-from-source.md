---
title: "Build from Source"
date: 2025-11-03
draft: false
weight: 5
---

# 5. Build from Source

> **DRAFT** - This document is currently in draft form and subject to change.

## Purpose

This section defines the standard practices for blockchain projects that require node software to be **built from source code**.
The goal is to ensure builds are **consistent, automatable, and verifiable**, enabling operators to reproduce the same binaries used across the network.

Projects should assume that many operators automate source builds in CI/CD pipelines or infrastructure-as-code workflows — meaning every step must be non-interactive and documented.

---

**Disclaimer:**
Building from source is **strongly discouraged** as the primary installation method for blockchain nodes. Projects should prioritize providing **precompiled binaries** and/or **container images** for official releases. Source builds increase operational complexity, slow down automation, and introduce potential inconsistencies across environments. This section is provided only for reference to ensure that, when source builds are necessary, they can be performed in a reliable and automated manner.

---

## 5.1 General Principles

Blockchain projects that provide source builds must:

- Support **deterministic builds** that produce identical binaries across systems.
- Clearly document all **dependencies, build tools, and environment variables**.
- Avoid manual or interactive installation steps.
- Publish signed **checksums and signatures** for all official build artifacts.
- Make all build instructions **machine-readable** and **automation-friendly** (e.g., usable by Ansible, GitHub Actions, or Docker).

---

## 5.2 Prerequisites & Environment Setup

Projects must document their build environment requirements in a dedicated `BUILD.md` file or within the main README.

**Minimum required documentation:**

- **Operating System:** Supported distributions and versions (e.g., Ubuntu 22.04+, Debian 12, Rocky 9).
- **Compiler Versions:** Minimum and tested versions of compilers (e.g., Go ≥1.21, Rust ≥1.77, GCC ≥12).
- **Dependencies:** System libraries, toolchains, and development packages.
- **Environment Variables:** Any variables that affect the build process (e.g., `CGO_ENABLED`, `LD_FLAGS`, `PATH` overrides).
- **Build User:** Whether builds must run as root or non-root users.

---

## 5.3 Build Commands

All projects must provide **clear, tested build commands** that can be executed directly after cloning the repository.

**Example (Go-based project):**

```bash
git clone https://github.com/example/blockchain.git
cd blockchain
make build
```

**Example (Rust-based project):**

```bash
git clone https://github.com/example/blockchain.git
cd blockchain
cargo build --release
```

---

## 5.4 Build Automation

The entire build process must be **automatable** and suitable for CI/CD integration.

**Requirements:**

- Provide a `Makefile`, `build.sh`, or equivalent automation script.
- Avoid requiring manual confirmation or terminal prompts.
- Support `CI` or `HEADLESS` modes via environment variables.
- Exit cleanly with meaningful error codes and logs.
- Allow for dependency caching to speed up builds.

---

## 5.5 Reproducibility

Projects should make builds **deterministic**, meaning they produce byte-for-byte identical binaries from the same source and environment.

**Recommended Practices:**

- Pin dependencies using version locks (`go.sum`, `Cargo.lock`, `package-lock.json`, etc.).
- Set build timestamps using environment variables (e.g., `SOURCE_DATE_EPOCH`).
- Use fixed compiler flags and linker options.
- Document how to verify reproducibility using checksum comparison.

---

## 5.6 Verification & Signatures

Projects should sign all build artifacts and provide verification instructions.

**Requirements:**

- Publish a `.sha256` or `.sha512` checksum file for each release.
- Provide a GPG-signed `.asc` file for authenticity verification.
- Include instructions in the documentation for verifying binary integrity.

---

> **Summary:**
> Building from source should be a predictable, secure, and automated process.
> Blockchain projects that follow these standards enable operators to reproduce builds, verify authenticity, and integrate seamlessly with CI/CD pipelines for decentralized and transparent network operations.
