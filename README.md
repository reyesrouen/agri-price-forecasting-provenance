Markdown
# Tamper-Evident Agricultural Price Forecasting & Provenance Pipeline

[![R Test Suite](https://github.com/reyesrouen/agri-price-forecasting-provenance/actions/workflows/r-tests.yml/badge.svg)](https://github.com/reyesrouen/agri-price-forecasting-provenance/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An end-to-end R pipeline that combines cryptographic data provenance (SHA-256 integrity verification and ECDSA digital signatures) with advanced time-series forecasting models (SARIMAX and Prophet) for agricultural commodities.

## System Architecture

+---------------------------+
|  Raw Agricultural Data    |
| (ncr_red_onions_weekly)   |
+-------------+-------------+
|
v
+---------------------------+
|   01_manifest_gen.R       | ---> Generates SHA-256 Hash +
| (Cryptographic Signing)   |      ECDSA (P-256) Digital Signature
+-------------+-------------+
|
v
+---------------------------+
|   02_verification_gate.R  | ---> Halts pipeline ([SECURITY HALT])
|   (Provenance Check)      |      if payload or signature is tampered
+-------------+-------------+
|
v [PASS / VERIFIED]
+---------------------------+
| 03_sarimax & 04_prophet   | ---> Executes price forecasting with
|   (Forecasting Engine)    |      exogenous macroeconomic variables
+---------------------------+


## Quick Start

### Execution
To execute the entire pipeline end-to-end:
```R
source("run_pipeline.R")
