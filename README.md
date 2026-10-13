# Cryptographically Verified Agricultural Price Forecasting

A robust time-series forecasting pipeline for Pampanga retail prices (SARIMAX & Prophet) backed by SHA-256 integrity hashing and ECDSA P-256 digital signature manifests.

## Pipeline Architecture
1. **Cryptographic Ingestion (`01_ingest_and_sign.R`):** Hashes datasets with SHA-256 and signs `signed_manifest.json` using ECDSA P-256.
2. **Verification (`02_verify_pipeline.R`):** Validates digital signatures to prevent data tampering.
3. **Data Alignment (`03_data_alignment.R`):** Aligns monthly target prices with weekly fuel/weather regressors using non-leaking lag operations.
4. **Forecasting (`04_forecasting.R`):** Evaluates SARIMAX and Prophet against baseline persistence models.

## Usage
```R
source("01_ingest_and_sign.R")
source("02_verify_pipeline.R")
source("03_data_alignment.R")
source("04_forecasting.R")

---

### Step 4: Commit and Push to GitHub

Run the following commands in the RStudio **Terminal**:

```bash
# 1. Stage all files
git add .

# 2. Commit the changes
git commit -m "Feat: Complete cryptographically signed agricultural forecasting pipeline"

# 3. Connect to your remote repository
git remote add origin https://github.com/reyesrouen/agri-price-forecasting-provenance.git

# 4. Push your code to main
git push -u origin main
