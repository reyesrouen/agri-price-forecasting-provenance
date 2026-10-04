library(digest)
library(openssl)
library(jsonlite)

# Verification gate: halts pipeline execution if data is tampered/corrupted
verify_data_integrity <- function(data_path, manifest_path, public_key) {
  manifest <- read_json(manifest_path)
  
  # 1. Verify SHA-256 hash match
  raw_bytes <- readBin(data_path, "raw", file.info(data_path)$size)
  current_hash <- digest::digest(raw_bytes, algo = "sha256", serialize = FALSE)
  
  if (current_hash != manifest$sha256_hash) {
    stop("[SECURITY HALT] Data payload hash mismatch! File has been tampered with or corrupted.")
  }
  
  # 2. Verify ECDSA signature
  sig_raw <- parse_hex(manifest$signature_ecdsa)
  is_valid <- openssl::signature_verify(charToRaw(current_hash), sig_raw, pubkey = public_key)
  
  if (!is_valid) {
    stop("[SECURITY HALT] Invalid ECDSA signature! Untrusted data source.")
  }
  
  message("[PASS / VERIFIED] Data integrity verified successfully.")
  return(TRUE)
}