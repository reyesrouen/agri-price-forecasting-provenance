# Tamper-Evident Agricultural Commodity Price Forecasting in Metro Manila

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R-Language](https://img.shields.io/badge/Language-R_4.3+-blue.svg)](https://www.r-project.org/)
[![Track](https://img.shields.io/badge/Track-Verifiable_Market_Data_%26_Supply_Chain_Integrity-green.svg)]()

An end-to-end reproducible R pipeline that combines asymmetric cryptographic provenance (**SHA-256** & **ECDSA P-256**) with econometric time-series forecasting (**SARIMAX** & **Prophet**) to predict retail price volatility for perishable agricultural staples (*Red Onions*) in Metro Manila while ensuring zero untrusted data ingestion.

---

## 📋 Table of Contents
- [Executive Summary](#-executive-summary)
- [System Architecture](#-system-architecture)
- [Repository Structure](#-repository-structure)
- [Prerequisites & Installation](#-prerequisites--installation)
- [Pipeline Usage](#-pipeline-usage)
- [Security Evaluation & Benchmarks](#-security-evaluation--benchmarks)
- [Forecasting Model Benchmarks](#-forecasting-model-benchmarks)
- [License & Citation](#-license--citation)

---

## 💡 Executive Summary
Modern machine learning pipelines in agricultural supply chains implicitly assume incoming price streams are authentic, complete, and uncorrupted. However, agricultural data collected across regional trading hubs (Divisoria, Balintawak) remain vulnerable to retrospective database edits, data spoofing, and key impersonation.

This repository implements a **two-tier architecture**:
1. **Cryptographic Provenance Layer:** Serializes raw CSV price feeds and exogenous variables (fuel prices, typhoon shock flags) into canonical JSON manifests signed via ECDSA P-256 and verified with SHA-256 byte hashing.
2. **Automated Pre-Ingestion Gate:** Intercepts invalid or unauthorized payloads before model fitting, guaranteeing 100% detection rate across adversarial vectors with $<10\text{ ms}$ latency overhead.
3. **Econometric Benchmarking:** Evaluates out-of-sample performance across 1-, 2-, and 4-week horizons using Prophet GAMs and SARIMAX ($xreg$) transfer functions.

---

## 🏗️ System Architecture
