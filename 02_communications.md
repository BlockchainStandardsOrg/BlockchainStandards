---
title: "Communications"
date: 2025-11-03
draft: false
weight: 2
---

# 2. Notifications & Communication

> **DRAFT** - This document is currently in draft form and subject to change.

## Purpose

This section defines standards for how blockchain projects should **notify and communicate** with node operators, validators, and the broader community.
Clear, timely, and structured communication ensures that network participants can prepare for software releases, upgrades, maintenance windows, and potential incidents without confusion or downtime.

---

## 2.1 Communication Principles

Projects must ensure that all communication channels and notifications are:

- **Timely:** Notices are shared with sufficient lead time before a release or maintenance event.
- **Accurate:** Information provided must be verified and consistent across all channels.
- **Accessible:** Channels should be publicly accessible and archived for later review.
- **Structured:** Use clear subject lines, version numbers, and environment identifiers (mainnet/testnet/devnet).

---

## 2.2 Official Communication Channels

Projects should maintain official communication channels for operators and developers.
Each channel should serve a defined purpose and remain consistent throughout the project's lifecycle. If Discord, allow Channel Following.

Channel Type | Purpose | Examples
--------------- | ---------- | -----------
**Validator Announcements** | Official outbound messages only. Used for Validator releases, maintenance, and incident notifications. | `#mainnet-validator-announcements`
**Validator Discussion / Support** | For community and operator Validator discussions, troubleshooting, and feedback. | `#mainnet-validator-discussion`, `#general`
**FullNode Announcements** | Official outbound messages only. Used for FullNode releases, maintenance, and incident notifications. | `#mainnet-fullnode-announcements`
**FullNode Discussion / Support** | For community and operator FullNode discussions, troubleshooting, and feedback. | `#mainnet-fullnode-discussion`

> **Standard:** Each network (mainnet, testnet, canary/devnet) should have its own *dedicated release announcement channel.*

---

## 2.3 Release Announcements

All blockchain projects **must** provide a formal process for announcing releases, upgrades, or critical patches.

A proper release announcement should include:

- **Version Number:** Follows the project's official semantic versioning scheme.
- **Release Type:** Specify if the update is *mandatory*, *optional*, or *critical security patch*.
- **Target Networks:** Clearly list whether the release applies to mainnet, testnet, or devnet.
- **Release Date & Time:** In **UTC**, with local time equivalents recommended.
- **Upgrade Instructions:** Link to release notes, binaries, or Docker image tags.
- **Rollback Guidance:** Include instructions for reverting if issues occur.
- **Chain Impact:** Indicate if the upgrade involves a hard fork, consensus change, or chain halt.
- **Testing Status:** Confirm that the release was tested on testnet or staging environments.

**Example Announcement Template:**

```text
📣 [Release] v1.2.4 - Mainnet & Testnet

Release Type: Mandatory Upgrade
Release Date: 2025-11-01 18:00 UTC
Networks Affected: Mainnet, Testnet

Summary:

Consensus bug fix for block timestamp issue

Adds new RPC endpoint /v1/state/snapshot

Improves validator signing performance

Upgrade Instructions:
https://docs.blockchainproject.org/releases/v1.2.4

SHA256 Checksum:
2f3f7b1d3a4e2...

Contact:
#mainnet-releases or devops@blockchainproject.org
```

---

## 2.4 Maintenance & Incident Notifications

Projects should communicate all planned and unplanned maintenance events in a consistent format.

### Planned Maintenance

- **Advance Notice:** Announce at least **72 hours in advance** of any mainnet downtime or upgrades.
- **Content:** Include purpose, estimated duration, and any expected user/operator impact.
- **Follow-up:** Confirm completion and post-mortem if delays or issues occur.

### Unplanned Incidents or Chain Halts

- **Immediate Notification:** Post to the incident or status channel as soon as detected.
- **Updates:** Provide regular progress updates until resolved.
- **Post-Mortem:** Publish a summary within **48 hours** of resolution, detailing cause and prevention steps.

---

## 2.5 Status Pages & Automation

Projects are encouraged to maintain a **public status page** for operational transparency.

Examples:

- `status.blockchainproject.org`
- `status.io` / `UptimeRobot` / `BetterStack` integrations.

Recommended Features:

- Real-time network health indicators (RPC latency, block height, peer count).
- Separate sections for **mainnet**, **testnet**, and **devnet**.
- Webhooks or RSS feeds for automated notifications.

---

## 2.6 Escalation & Contact Information

Projects must provide:

- A clear escalation path for critical issues (security, chain halt, emergency patching).
- Contact options:
  - **Email:** `security@project.org`, `ops@project.org`
  - **Incident Channel:** Dedicated Discord/Slack thread.
- Escalation response time targets (e.g., within 1 hour for critical mainnet incidents).

---

## 2.7 Archiving & Transparency

- All announcements, release notes, and incident reports should be archived in a **public repository** (e.g., `project/releases` or `project/status` on GitHub).
- Maintain **persistent URLs** for each release and announcement.
- Encourage usage of **RSS/Atom feeds** for operators who prefer automated tracking.

---

> **Summary:**
> Standardized, timely communication channels and structured release notifications are critical to network reliability and operator trust.
> Every blockchain project should maintain transparent, versioned, and automation-friendly communication practices to ensure operational stability.
