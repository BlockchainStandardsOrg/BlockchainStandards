---
title: "Development Practices"
date: 2025-11-03
draft: false
weight: 3
---

# 3. Development Practices

> **DRAFT** - This document is currently in draft form and subject to change.

## Purpose

This section defines the minimum standards for blockchain development and release management practices.
The goal is to ensure that all blockchain projects produce **versioned, reproducible, and traceable releases** that operators can confidently deploy in production and test environments.

While the Software Development Lifecycle (SDLC) encompasses many stages and practices, this section focuses specifically on the key aspects most relevant to supporting infrastructure operators.

---

## 3.1 Versioning Standards

Projects **must** use a consistent and predictable versioning system.

### Semantic Versioning (SemVer)

All blockchain projects should follow [Semantic Versioning 2.0.0](https://semver.org/), using the format:

```text
MAJOR.MINOR.PATCH
```

- **MAJOR:** Incompatible protocol or API changes.
- **MINOR:** Backward-compatible feature additions.
- **PATCH:** Backward-compatible bug fixes or security patches.

Projects **must not** instruct operators to "check out a specific commit hash" as the only supported build method (especially for testnet/mainnet).
Every deployable release must correspond to a **git tag** and a **versioned changelog entry**.

---

## 3.2 Tagged Releases

Each official release must be **tagged in the source repository** and include:

- A **signed git tag** (`git tag -s vX.Y.Z -m "Release vX.Y.Z"`).
- **Release notes** summarizing changes, upgrade instructions, and compatibility notes.
- Links to pre-built binaries or container images (if applicable).

**Example Git Tag Command:**

```bash
git tag -s v1.2.0 -m "Release v1.2.0 - Network Upgrade Alpha"
git push origin v1.2.0
```

---

## 3.3 Changelogs

A project **must maintain** a `CHANGELOG.md` file at the root of the repository.

This changelog should:

- Be **human-readable** and **version-aligned** with git tags.
- Follow [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) formatting.
- Include dates, change categories, and release links.

**Example Entry:**

```markdown
## [v1.2.0] - 2025-10-16
### Added
- Introduced `state-sync` optimization for faster node bootstrapping.
- Added `metrics` endpoint for Prometheus integration.

### Fixed
- Resolved peer connection leak under high load.

### Changed
- Upgraded Go runtime to 1.23 for performance improvements.
```

---

> **Summary:**
> Standardized versioning, reproducible builds, and transparent release engineering are essential for operator confidence and ecosystem stability.
> Blockchain projects that follow these practices ensure predictable upgrades, faster debugging, and secure validation of node software.
