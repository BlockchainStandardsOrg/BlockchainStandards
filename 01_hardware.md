---
title: "Hardware Requirements"
date: 2025-11-03
draft: false
weight: 1
---

# 1. Hardware Requirements

> **DRAFT** - This document is currently in draft form and subject to change.

## Purpose

This section defines the standard practices for how blockchain projects should document their hardware and infrastructure requirements.
The goal is to provide **clear, reproducible, and complete specifications** that allow operators to accurately provision resources before deployment.

---

## 1.1 Deployment Environment

Projects **must specify**:

- Whether nodes can run on **bare metal**, **virtual machines**, or **cloud instances**.
- Any **virtualization limitations** (e.g., IOMMU, nested virtualization, CPU instruction dependencies).
- Supported **operating systems** (name, version, architecture).
- Minimum and recommended **kernel versions** and **system dependencies**.

---

## 1.2 Server Role Definitions

Projects should define each server type required to participate in the network. Each role must include its purpose, whether it is **mandatory or optional**, and the number of instances typically required per operator.

Role | Purpose | Mandatory | Typical Quantity
------ | ---------- | ------------ | ------------------
**Validator Node** | Participates in consensus; signs blocks/transactions. | ✅ | 1
**Sentinel / Sentry Node** | Protects validator node by proxying network connections. | ✅ (for secure setups) | 2–3
**Full Node** | Maintains full blockchain state for queries. | Optional | 1+
**Archive Node** | Keeps full historical state; often used by indexers/explorers. | Optional | 1
**RPC/API Node** | Handles user or dApp requests; may be load-balanced. | Optional | 1+
**Indexer / Indexing DB** | Builds and serves queryable data. | Optional | 1
**Database** | Backend database for storing blockchain data. | Optional | 1

Projects should **clearly identify** which roles are *required for network participation* and which are *optional for extended services*.

---

## 1.3 Hardware Specifications

Each role must have documented **minimum** and **recommended** specifications:

Component | Minimum | Recommended | Notes
------------ | ---------- | -------------- | -------
**CPU** | 4 vCPU | 8+ vCPU | Modern x86_64 or ARM64
**RAM** | 8 GB | 16–32 GB | Avoid swap usage
**Disk Type** | SSD | NVMe | HDD not permitted for production validators
**Disk Size** | 500 GB | 2 TB+ | Depends on chain history and pruning
**Network Bandwidth** | 100 Mbps | 1 Gbps+ | Symmetric uplink/downlink preferred
**Latency** | <100 ms | <50 ms | Between validator and peers

Additional guidance:

- **Disk Type Requirements:** Projects must specify whether **standard disk**, **SSD**, **NVMe**, or high-IOPS block storage is required.
- **Storage Growth Rate:** Document expected blockchain data growth (daily, monthly, or yearly).
- **Backup Recommendations:** Include procedures for snapshots or block-level backups.

---

## 1.4 Node Count and Network Participation

Projects must clarify:

- **Minimum node count** required for participation (e.g., 1 validator + 2 sentries).
- Whether operators are **required or encouraged** to run multiple environments:
  - **Mainnet:** Production network.
  - **Testnet:** Used for pre-release and upgrade validation.
  - **Canary/Devnet:** Used for early feature testing.
- Explicitly state if:
  - Running **testnet participation** is *mandatory* for validators.
  - Operators **may opt out** of devnet participation.
  - Testnet and mainnet may be run on **shared or separate infrastructure**.

---

## 1.5 Network and Connectivity

Projects should document:

- **P2P Port Requirements:** Inbound/outbound ports, protocols (TCP/UDP), and firewall rules.
- **External Connectivity:** Whether nodes require public IPs or can operate behind NAT.
- **Load Balancing:** If RPC nodes support horizontal scaling.
- **Geo-distribution Requirements:** For redundancy or staking diversity (if applicable).

---

## 1.6 Additional Recommendations

Projects should also:

- Provide **infrastructure diagrams** showing minimal and recommended deployment topologies.
- Specify whether **GPU acceleration** is required (for cryptographic workloads).
- Document any **cloud provider limitations** (e.g., unsupported instance types or architectures).
- Offer **cost estimation guidance** (optional but useful for validator resource planning).

---

> **Summary:**
> Blockchain projects should provide complete, transparent, and automation-friendly hardware documentation to ensure node operators can deploy confidently and consistently across environments.
