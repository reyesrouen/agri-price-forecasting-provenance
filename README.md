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

[ Raw CSV Price Data ] + [ Exogenous Variables (Fuel & Typhoons) ]
│
▼
[ Algorithm A: Cryptographic Manifest Generator ]
(SHA-256 Hashing + ECDSA P-256 Signing)
│
▼
[ Algorithm B: Automated Pre-Ingestion Gate ]
│
┌──────────────────┴──────────────────┐
│                                     │
[ REJECT / HALT ]                     [ PASS / VERIFIED ]
(Tampered / Impersonated)                       │
▼
┌──────────────┴──────────────┐
│                             │
▼                             ▼
[ SARIMAX (xreg) ]             [ Prophet GAM ]


---

## 📁 Repository Structure

```text
├── data/
│   ├── raw/                   # Raw CSV price series and exogenous logs
│   ├── verified/              # Cryptographically verified clean datasets
│   └── manifests/             # Canonical JSON manifests with ECDSA signatures
├── R/
│   ├── 01_manifest_gen.R      # Algorithm A: SHA-256 hashing & signature gen
│   ├── 02_verification_gate.R # Algorithm B: Pre-ingestion validation gate
│   ├── 03_sarimax_models.R    # SARIMAX univariate and exogenous pipelines
│   └── 04_prophet_models.R    # Prophet GAM fitting & prior scale tuning
├── tests/
│   └── test_security.R        # Adversarial attack tests (mutation, spoofing)
├── config.yml                 # Key paths and model parameters
├── run_pipeline.R             # Main execution controller script
├── README.md                  # Project documentation
└── LICENSE                    # MIT License
