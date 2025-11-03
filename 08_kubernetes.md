---
title: "Kubernetes"
date: 2025-11-03
draft: false
weight: 8
---

# 8. Kubernetes

> **DRAFT** - This document is currently in draft form and subject to change.

## Purpose

This section defines the standards for blockchain projects that support deployment on **Kubernetes** or similar orchestration platforms (e.g., OpenShift, K3s, GKE, EKS, AKS).
The goal is to ensure blockchain workloads are **portable, configurable, and automation-ready** — enabling operators to run validator, RPC, and indexer nodes at scale with high availability.

---

## 8.1 Principles

Kubernetes deployments for blockchain nodes should be:

- **Declarative:** Managed entirely by version-controlled manifests or Helm charts.
- **Composable:** Allow integration with standard tools like Prometheus, Grafana, and Vault.
- **Secure:** Enforce least-privilege policies via Kubernetes RBAC and network segmentation.
- **Observable:** Expose metrics and logs natively for monitoring.
- **Customizable:** Support variable overrides for all critical parameters (resources, ports, configs).
- **Automatable:** Support rolling upgrades and GitOps workflows without manual steps.

---

## 8.2 Official Kubernetes Artifacts

Blockchain projects should publish **official Helm charts or manifests** under their main repository or a dedicated `charts/` or `kubernetes/` directory.

**Minimum Requirements:**

- Helm Chart (`Chart.yaml`, `values.yaml`, `templates/`)
- Kustomize manifests (if Helm is not used)
- Versioned chart releases matching the software version (e.g., `v1.3.0` → chart `1.3.0`)
- Installation instructions (`README.md`)

**Example Helm Install Command:**

```bash
helm repo add blockchain https://charts.blockchainproject.org
helm install validator blockchain/validator --version 1.3.0
```

---

## 8.3 Configuration & Customization

All configuration parameters should be **exposed via Helm values** or manifest variables.
No configuration value should require editing a template file directly.

**Examples of Exposed Variables:**

| Parameter | Type | Default | Description |
|------------|------|----------|-------------|
| `chainId` | string | `mainnet-1` | Blockchain network identifier |
| `nodeType` | string | `validator` | Node role: validator, fullnode, RPC |
| `persistence.enabled` | bool | `true` | Enables persistent volume claims |
| `resources.requests.cpu` | string | `2` | Minimum CPU request |
| `resources.limits.memory` | string | `8Gi` | Max memory limit |
| `service.type` | string | `ClusterIP` | Kubernetes service type |
| `env` | map | `{}` | Custom environment variables |

---

## 8.4 Resource Requests & Limits

Projects must define **default CPU and memory limits** appropriate for production use.

**Example:**

```yaml
resources:
  requests:
    cpu: "2"
    memory: "8Gi"
  limits:
    cpu: "4"
    memory: "16Gi"
```

Projects should provide performance guidance for validators, full nodes, and RPC nodes based on chain size and workload.

---

## 8.5 Persistent Storage

Persistent blockchain state should use **PersistentVolumeClaims (PVCs)** with configurable storage classes.

**Example PVC Configuration:**

```yaml
persistence:
  enabled: true
  storageClass: "fast-nvme"
  accessModes:
    - ReadWriteOnce
  size: 2Ti
  mountPath: /data
```

**Best Practices:**

- Use high-IOPS SSD or NVMe-backed storage for validators.
- Separate data volumes for logs and chain data (if applicable).
- Ensure data survives pod restarts or rescheduling.

---

## 8.6 Networking & Services

Kubernetes manifests should clearly define:

- **Service ports** for P2P, RPC, and API communication.
- **Ingress or LoadBalancer options** for public endpoints.
- **Pod networking policies** to restrict traffic between nodes and components.
- **DNS configuration** for node discovery or peer connections.

---

## 8.7 Secrets & Key Management

Projects must provide secure methods for handling validator keys and sensitive credentials.

**Best Practices:**

- Use **Kubernetes Secrets** for private keys and credentials.
- Support integration with **HashiCorp Vault**, **AWS/GCP Secret Managers**, or **Sealed Secrets**.
- Avoid embedding secrets directly in Helm values or ConfigMaps.
- Provide key rotation documentation.

---

## 8.8 Monitoring & Observability

Blockchain deployments should integrate seamlessly with observability tools.

**Requirements:**

- Expose Prometheus metrics via `ServiceMonitor` or annotations.
- Provide default Grafana dashboards in the chart repository.
- Emit structured logs for ingestion by Loki or ELK.

---

## 8.9 Rolling Upgrades

Projects should support **zero-downtime upgrades** and **versioned Helm releases**.

**Guidelines:**

- Use `RollingUpdate` strategy for statefulsets and deployments.
- Avoid immutable image tags like `latest`; use versioned tags.
- Support pre-upgrade and post-upgrade hooks for schema or config migrations.
- Provide example upgrade commands and rollback procedures.

**Example Upgrade Command:**

```bash
helm upgrade validator blockchain/validator --version 1.3.1
```

---

## 8.10 GitOps & Automation

Helm charts and manifests should be compatible with **GitOps workflows** (ArgoCD, FluxCD).

**Recommendations:**

- Store manifests in version-controlled repositories.
- Use automated sync policies for production networks.
- Validate configuration through CI/CD before applying.
- Provide example GitOps repository structures.

---

## 8.11 Security & Policy

Projects should follow Kubernetes security best practices:

- Use **PodSecurityStandards: baseline or restricted**.
- Drop unnecessary Linux capabilities.
- Run as **non-root** user.
- Set `readOnlyRootFilesystem: true` where possible.
- Enforce **RBAC roles** for least-privilege access.
- Document network policies limiting peer and API access.

---

> **Summary:**
> Kubernetes enables blockchain networks to operate with automation, scalability, and reliability.
> Projects should provide secure, versioned Helm charts and manifests with full configurability for operators — ensuring seamless upgrades, observability, and multi-network deployments.
