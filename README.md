# Tamper-Evident Agricultural Price Forecasting & Provenance Pipeline

An end-to-end R pipeline that combines cryptographic data provenance (SHA-256 integrity verification and ECDSA digital signatures) with time-series forecasting models (SARIMAX and Prophet) for agricultural commodities.

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


## How to Run

### Execute the Pipeline
```R
source("run_pipeline.R")
Run Security Tests
R
testthat::test_dir("tests")
Project Structure
R/01_manifest_gen.R: Manifest creation and ECDSA keypair generation.

R/02_verification_gate.R: SHA-256 hash matching and ECDSA signature verification.

R/03_sarimax_models.R: SARIMAX time-series model fitting.

R/04_prophet_models.R: Prophet forecasting implementation.

data/raw/: Raw CSV agricultural price datasets.

data/manifests/: Cryptographic JSON manifests.

tests/test_security.R: Security halt verification unit test.

run_pipeline.R: Master orchestrator script.
