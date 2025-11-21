---
title: "Binary Installation"
date: 2025-11-03
draft: false
weight: 6
---

# 6. Binary Installation Packages

> **DRAFT** - This document is currently in draft form and subject to change.

## Purpose

This section defines best practices for distributing blockchain software as **binary installation packages**, including `.tar.gz`, `.zip`, `.deb` (APT), and `.rpm` (YUM/DNF) formats.

---

## 6.1 Distribution Methods

Projects should provide one or more standardized binary distribution formats:

Format | Use Case | Example
---------|-----------|----------
**Tarball (.tar.gz)** | Portable Linux installations | `blockchain-v1.3.0-linux-amd64.tar.gz`
**Zip Archive (.zip)** | Cross-platform (Windows/macOS) | `blockchain-v1.3.0-windows-x64.zip`
**APT Package (.deb)** | Debian/Ubuntu repositories | `apt install blockchain-node`
**RPM Package (.rpm)** | RHEL/Fedora/CentOS | `dnf install blockchain-node`

All official binaries must be:

- **Versioned** (e.g., `v1.3.0`, not `latest`).
- **Digitally signed** and accompanied by SHA256 checksums.
- **Hosted on a stable, versioned URL structure** (e.g., `https://releases.blockchain.org/v1.3.0/linux/`).
- **Consistent across environments** (mainnet/testnet paths differ only by environment name).

---

## 6.2 Package Contents

Binary packages must contain all necessary components for operation without requiring compilation.

**Minimum Contents:**

- Executable binary (e.g., `blockchain`, `validatord`, etc.)
- Default configuration template (`config.toml`, `.yaml`)
- Example systemd service file (e.g., `blockchain.service`)
- Documentation or README
- License file

---

## 6.3 Installation Process

Installation should follow standard OS conventions and avoid custom or interactive steps.

**Examples:**

**APT (Debian/Ubuntu):**

```bash
curl -fsSL https://releases.blockchain.org/gpg.key | sudo apt-key add -
echo "deb [arch=amd64] https://releases.blockchain.org/apt stable main" | sudo tee /etc/apt/sources.list.d/blockchain.list
sudo apt update && sudo apt install blockchain-node
```

**RPM (CentOS/RHEL):**

```bash
sudo rpm --import https://releases.blockchain.org/gpg.key
sudo dnf install https://releases.blockchain.org/yum/blockchain-node-latest.rpm
```

**Tarball:**

```bash
wget https://releases.blockchain.org/v1.3.0/blockchain-v1.3.0-linux-amd64.tar.gz
tar -xzf blockchain-v1.3.0-linux-amd64.tar.gz -C /usr/local/bin
```

---

## 6.4 Configuration & Environment

- Support configuration through environment variables, CLI flags, and config files.
- Avoid hard-coded paths.
- Ensure the binary runs correctly as a **non-root user**.
- Provide example configuration files for validator, full, and RPC nodes.
- Include `--help` and `version` flags for verification.

---

## 6.5 Verification

Every distributed binary must include:

- GPG or Sigstore signatures for authenticity.
- SHA256 or SHA512 checksum files.
- Clear verification instructions in documentation.

**Example Verification:**

```bash
gpg --verify blockchain-v1.3.0-linux-amd64.tar.gz.asc
sha256sum -c blockchain-v1.3.0-linux-amd64.tar.gz.sha256
```

---

## 6.6 Automation & Integration

Binaries must integrate cleanly with automation frameworks and deployment pipelines.

**Requirements:**

- Installation steps must be **scriptable and idempotent**.
- Package URLs and naming must be **consistent** across releases and environments.
- Avoid steps that depend on custom scripts or manual intervention.
- Provide exit codes for success/failure.
- Ensure backward compatibility of CLI flags across minor versions when possible.

---

> **Summary:**
> Binary installation packages are the preferred distribution method for blockchain projects.
> They ensure consistent, verifiable, and automation-friendly deployments across environments, greatly reducing operational complexity for node operators.
