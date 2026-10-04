source("R/01_manifest_gen.R")
source("R/02_verification_gate.R")
source("R/03_sarimax_models.R")
source("R/04_prophet_models.R")

message("=== Starting Tamper-Evident Agri-Price Pipeline ===")

# 1. Key Generation & Manifest Creation
keys <- generate_keypair()
manifest <- create_data_manifest("data/raw/ncr_red_onions_weekly.csv", keys$private, "data/manifests/ncr_red_onions_manifest.json")

# 2. Verification Gate Execution
verify_data_integrity("data/raw/ncr_red_onions_weekly.csv", "data/manifests/ncr_red_onions_manifest.json", keys$public)

# 3. Model Training & Forecasting
df <- read.csv("data/raw/ncr_red_onions_weekly.csv")
sarimax_fit <- fit_sarimax_model(df)
message("Pipeline executed successfully!")