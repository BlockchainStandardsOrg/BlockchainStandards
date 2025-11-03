---
title: "Monitoring & Observability"
date: 2025-11-03
draft: false
weight: 11
---

# 11. Monitoring & Observability

> **DRAFT** - This document is currently in draft form and subject to change.

## Purpose

This section establishes the standards for **monitoring and observability** in blockchain infrastructure.
Monitoring provides visibility into system health, performance, and network state — enabling proactive detection of issues and faster recovery during incidents.

The goal is to define a consistent approach to metrics, logs, and tracing so node operators, validators, and developers can monitor blockchain systems in a standardized, interoperable way.

---

## 11.1 Principles

All blockchain projects should design for observability using the following principles:

- **Transparency:** Expose metrics that allow operators to understand system state and performance.
- **Standardization:** Use industry-standard protocols like Prometheus, OpenTelemetry, and JSON logs.
- **Automation:** Monitoring should deploy easily alongside the node (e.g., via Helm, Docker, or Ansible).
- **Actionability:** Metrics and logs must support alerting and incident response workflows.
- **Security:** Ensure that metrics and logs do not expose sensitive data or credentials.

---

## 11.2 Metrics

Blockchain nodes must expose **Prometheus-compatible metrics** endpoints for scraping.

**Requirements:**

- Metrics endpoint accessible via HTTP (`/metrics`).
- All numeric metrics include type (`counter`, `gauge`, `histogram`).
- Use consistent naming: `blockchain_<component>_<metric>`.
- Include help text and units for each metric.

**Example Endpoint:**

```prometheus
GET /metrics
# HELP blockchain_block_height Current blockchain height
# TYPE blockchain_block_height gauge
blockchain_block_height 123456

# HELP blockchain_peer_count Number of connected peers
# TYPE blockchain_peer_count gauge
blockchain_peer_count 22
```

**Recommended Metrics Categories:**

| Category | Example Metrics | Description |
|-----------|------------------|-------------|
| **Consensus** | `block_height`, `consensus_rounds_total` | Tracks chain progress and validator participation |
| **Network** | `peer_count`, `p2p_bytes_sent_total` | Measures network connectivity |
| **Storage** | `disk_usage_bytes`, `db_write_latency_seconds` | Monitors disk health and performance |
| **System** | `cpu_usage`, `memory_usage`, `file_descriptors` | Reports resource consumption |
| **RPC/API** | `rpc_requests_total`, `rpc_errors_total` | Monitors user/API interactions |
| **Mempool** | `tx_pool_size`, `tx_latency_seconds` | Tracks transaction handling |
| **Validator** | `blocks_signed_total`, `missed_blocks_total` | Monitors validator performance and uptime |

---

## 11.3 Logging

Logs are essential for diagnosing and auditing blockchain operations.
Projects must define **structured logging standards**.

**Requirements:**

- Output logs to **stdout/stderr** for container compatibility.
- Use **JSON format** for machine readability.
- Include timestamps, severity, component, and message.
- Support configurable verbosity (`error`, `warn`, `info`, `debug`).
- Avoid leaking sensitive data (private keys, tokens).

**Example Log Line (JSON):**

```json
{
  "level": "info",
  "timestamp": "2025-10-16T12:01:45Z",
  "component": "consensus",
  "msg": "Proposed new block",
  "height": 123456,
  "round": 2,
  "txs": 13
}
```

**Log Levels:**

| Level | Description |
|--------|--------------|
| `error` | Critical issue or crash |
| `warn` | Unexpected but recoverable condition |
| `info` | Standard operational event |
| `debug` | Detailed tracing for development/testing |

---

## 11.4 Tracing

For complex distributed systems, **distributed tracing** helps track requests and block propagation across nodes.

**Recommendations:**

- Support **OpenTelemetry** for distributed tracing.
- Tag traces with node ID, block height, and transaction hash.
- Integrate with tracing backends (Jaeger, Tempo, Datadog).
- Document how to enable tracing in configuration.

---

## 11.5 Dashboards

Projects should provide **prebuilt dashboards** for Prometheus/Grafana to visualize node performance.

**Required Dashboards:**

1. **Node Overview:** CPU, memory, peers, and block height.
2. **Consensus Dashboard:** Block production, validator uptime, missed blocks.
3. **Network Dashboard:** Latency, P2P connections, and RPC throughput.
4. **Mempool/Transaction Dashboard:** Queue depth and processing latency.
5. **Storage Dashboard:** Disk usage, I/O rates, and pruning status.

Projects should include JSON export files for dashboards in `/monitoring/grafana/` or `/charts/` directories.

---

## 11.6 Alerting & Incident Response

Monitoring systems should trigger alerts for abnormal conditions.

**Recommended Alert Rules (PromQL):**

```promql
# Node stopped producing blocks
increase(blockchain_blocks_produced_total[5m]) == 0

# Peer count dropped below threshold
blockchain_peer_count < 5

# Node not syncing or out of consensus
blockchain_sync_height_diff > 10
```

**Alert Channels:**

- Slack / Discord
- PagerDuty / OpsGenie
- Email / Webhooks

---

## 11.7 Health Checks

Nodes should provide internal or external **health endpoints** for automation and orchestration.

**Standard Health Endpoint:**

```text
GET /health
{
  "status": "ok",
  "height": 123456,
  "syncing": false,
  "peers": 22
}
```

**Use Cases:**

- Docker `HEALTHCHECK`
- Kubernetes `livenessProbe` and `readinessProbe`
- External uptime monitoring (UptimeRobot, Prometheus blackbox exporter)

---

## 11.8 Monitoring Stack Integration

Blockchain projects should provide integration examples with popular monitoring stacks.

**Recommended Stack Components:**

| Component | Purpose |
|------------|----------|
| **Prometheus** | Metric collection |
| **Grafana** | Visualization |
| **Loki** | Centralized log aggregation |
| **Alertmanager** | Alert routing and notifications |
| **Tempo / Jaeger** | Distributed tracing |

---

## 11.9 Data Retention & Compliance

Projects must define **log and metric retention policies** to balance visibility and cost.

**Recommendations:**

- Retain operational logs for at least **30 days**.
- Retain validator or governance logs for **90 days**.
- Ensure compliance with regional data protection regulations (GDPR, etc.).
- Provide guidance for log rotation and archival.

---

## 11.10 Community & Ecosystem Monitoring

Projects should promote **public transparency** by supporting shared monitoring tools.

**Best Practices:**

- Publish public status pages for mainnet/testnet uptime.
- Provide community Grafana dashboards and APIs.
- Encourage operator participation in distributed monitoring networks (e.g., Polkachu, Tenderduty, Nodewatch).
- Support monitoring APIs for validators to expose performance data safely.

---

> **Summary:**
> Observability is critical to maintaining the health and security of blockchain networks.
> Projects should implement consistent metrics, structured logging, and tracing to enable automated monitoring, quick incident response, and transparent performance insights for operators and the community.
