# ==============================================================================
# DEMO: Live Cryptographic Security Halt Demonstration
# ==============================================================================

library(here)
source(here::here("R/01_manifest_gen.R"))
source(here::here("R/02_verification_gate.R"))

message(">>> Step 1: Generating keypair and manifest for raw data...")
keys <- generate_keypair()
data_path <- here::here("data/raw/ncr_red_onions_weekly.csv")
manifest_path <- here::here("data/manifests/demo_manifest.json")

create_data_manifest(data_path, keys$private, manifest_path)

message("\n>>> Step 2: Verifying UNTAMPERED data...")
verify_data_integrity(data_path, manifest_path, keys$public)

message("\n>>> Step 3: Modifying price data (simulating data tampering)...")
raw_lines <- readLines(data_path)
tampered_lines <- raw_lines
tampered_lines[2] <- gsub("180.0", "999.0", tampered_lines[2])

temp_tampered_file <- tempfile(fileext = ".csv")
writeLines(tampered_lines, temp_tampered_file)

message(">>> Step 4: Re-running verification gate on TAMPERED file...")
tryCatch(
  {
    verify_data_integrity(temp_tampered_file, manifest_path, keys$public)
  },
  error = function(e) {
    message("\n[SUCCESSFUL DEMO] Security Gate Caught Tampering!")
    message("Error Intercepted: ", e$message)
  }
)

# Cleanup
if (file.exists(manifest_path)) file.remove(manifest_path)
if (file.exists(temp_tampered_file)) file.remove(temp_tampered_file)
