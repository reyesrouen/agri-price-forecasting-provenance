# Cryptographically Verified Agricultural Price Forecasting

A tamper-evident multivariate time-series forecasting pipeline for onion retail prices in Pampanga, Philippines. This prototype integrates SARIMAX and Meta Prophet models while guaranteeing data provenance through SHA-256 integrity hashing and ECDSA (P-256) digital signatures.

![Prophet Forecast Plot](data/processed/prophet_forecast_plot.png)

## Pipeline Architecture

1. **Cryptographic Ingestion (`01_ingest_and_sign.R`)**: Hashes raw datasets with SHA-256 and signs the manifest via ECDSA P-256.
2. **Pipeline Verification (`02_verify_pipeline.R`)**: Validates manifest signatures prior to execution to prevent model training on tampered data.
3. **Data Alignment & Lags (`03_data_alignment.R`)**: Merges target price series with fuel and weather regressors, enforcing non-leaking lags (7-day fuel, 14-day rainfall).
4. **Forecasting & Benchmarking (`04_forecasting.R`)**: Fits Naive, Seasonal Naive, ARIMA, SARIMAX, and Prophet models with expanding-window evaluation.

## Execution

Run the scripts sequentially in RStudio:

```R
source("01_ingest_and_sign.R")
source("02_verify_pipeline.R")
source("03_data_alignment.R")
source("04_forecasting.R")
