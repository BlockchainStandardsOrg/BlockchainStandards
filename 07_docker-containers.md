---
title: "Docker Containers"
date: 2025-11-03
draft: false
weight: 7
---

# 7. Docker / Containers

> **DRAFT** - This document is currently in draft form and subject to change.

## Purpose

This section establishes standards for blockchain projects that provide or support **containerized deployments** using Docker, Podman, or compatible OCI runtimes.
The goal is to ensure that containers are **secure, consistent, and automation-ready**, allowing operators to deploy nodes and supporting services with minimal manual configuration.

---

## 7.1 Containerization Principles

Blockchain container images must:

- Be **lightweight**, **versioned**, and **OCI-compliant**.
- Contain only the **necessary binaries and dependencies** for runtime.
- Use **non-root** users by default for security.
- Expose configuration through **environment variables** or **mounted configuration files**.
- Be suitable for **automated orchestration** (e.g., Docker Compose, Kubernetes).
- Provide **health checks**, **logs**, and **metrics** endpoints when possible.

---

## 7.2 Official Images

Projects that distribute Docker images must:

- Publish official, signed container images to a trusted registry:
  - **Docker Hub:** `docker.io/project/blockchain`
  - **GitHub Container Registry (GHCR):** `ghcr.io/project/blockchain`
  - **Quay.io** or other trusted registries.
- Clearly document where the official images are hosted and who maintains them.
- Tag each image with:
  - A **semantic version tag** (e.g., `v1.2.3`)
  - A **commit hash tag** (e.g., `sha-8f3b2a1`)
  - Optionally, `latest` for convenience, though it should not be used in production automation.

---

## 7.3 Base Image Requirements

Containers should be built using **minimal and secure base images**.

**Recommendations:**

- Prefer **distroless** or **Alpine Linux** base images where possible.
- Avoid full OS base images (e.g., Ubuntu, Debian) unless required for dependencies.
- Regularly update base images for security patches.
- Pin the base image version explicitly in the `Dockerfile`.

---

## 7.4 Configuration Management

Containerized deployments must allow configuration through:

- **Environment variables** (e.g., `BLOCKCHAIN_CONFIG_PATH=/config/config.toml`)
- **Mounted configuration files** (volumes)
- **Command-line arguments** passed via entrypoint or CMD

**Standard Practice:**

- Document all configurable environment variables and their defaults.
- Avoid hardcoding configuration paths.
- Allow operators to override node parameters (e.g., ports, RPC endpoints, chain IDs) without rebuilding the image.

---

## 7.5 Health Checks

Containers must include health checks that verify node and process availability.

**Example Dockerfile:**

```dockerfile
HEALTHCHECK --interval=30s --timeout=10s --start-period=1m \
  CMD curl -f http://localhost:26657/health || exit 1
```

Health checks allow orchestration platforms like Docker Swarm or Kubernetes to detect and replace failed containers automatically.

---

## 7.6 Logging and Metrics

Container logs should:

- Output to **stdout/stderr** for compatibility with Docker logging drivers.
- Use **structured JSON** or plaintext with timestamps.
- Avoid writing directly to disk inside the container.

Projects should provide documentation for:

- Integrating with log aggregation tools (e.g., Loki, Fluentd, ELK).
- Accessing metrics endpoints (e.g., Prometheus).

---

## 7.7 Persistent Data & Volumes

Projects must document how to manage persistent blockchain data volumes.

**Recommendations:**

- Store chain data and configuration in a mounted volume (`/data`).
- Use separate volumes for logs, configuration, and blockchain state.
- Do not store private keys directly in the image.

**Example Volume Mapping:**

```bash
docker run -d \
  --name blockchain-node \
  -v /var/lib/blockchain:/data \
  -v /etc/blockchain:/config \
  project/blockchain:v1.3.0
```

---

## 7.8 Networking

Document all ports and protocols used by the node, and ensure they are explicitly exposed in the Dockerfile.

**Example:**

```dockerfile
EXPOSE 26656/tcp 26657/tcp
```

**Standard Networking Requirements:**

- Avoid fixed IP dependencies — containers must work in dynamic environments.
- Support both IPv4 and IPv6.
- Clearly specify which ports are for:
  - P2P communication
  - RPC/API access
  - Prometheus metrics

---

## 7.9 Docker Compose Examples

Projects should provide a reference `docker-compose.yml` file to simplify multi-service setups (e.g., validator + RPC node + monitoring).

**Example Compose File:**

```yaml
version: '3.9'
services:
  blockchain:
    image: project/blockchain:v1.3.0
    container_name: blockchain-node
    environment:
      - BLOCKCHAIN_CHAIN_ID=mainnet-1
    volumes:
      - ./data:/data
      - ./config:/config
    ports:
      - "26656:26656"
      - "26657:26657"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:26657/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

---

## 7.10 Security & Best Practices

- Do **not** run as root — use non-root users by default.
- Keep the container stateless — configuration and data belong on external volumes.
- Sign container images using [Sigstore Cosign](https://docs.sigstore.dev/cosign/overview/).
- Regularly scan for vulnerabilities using Trivy, Clair, or Grype.
- Avoid embedding private keys or credentials in images or environment variables.

---

> **Summary:**
> Blockchain projects should provide clean, secure, and automation-ready container images that follow best practices for configuration, health checking, and observability.
> Proper containerization ensures reliable, reproducible deployments across local, cloud, and orchestrated environments.
