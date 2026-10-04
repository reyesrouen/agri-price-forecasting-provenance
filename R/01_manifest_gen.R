library(digest)
library(openssl)
library(jsonlite)

generate_keypair <- function() {
  key <- openssl::ec_keygen(curve = "P-256")
  pubkey <- as.list(key)$pubkey
  list(private = key, public = pubkey)
}

create_data_manifest <- function(data_path, private_key, output_manifest_path) {
  raw_bytes <- readBin(data_path, "raw", file.info(data_path)$size)
  data_hash <- digest::digest(raw_bytes, algo = "sha256", serialize = FALSE)
  
  signature <- openssl::signature_create(charToRaw(data_hash), key = private_key)
  sig_hex <- paste(as.character(signature), collapse = "")
  
  manifest <- list(
    file_name = basename(data_path),
    sha256_hash = data_hash,
    signature_ecdsa = sig_hex,
    timestamp = as.character(Sys.time())
  )
  
  write_json(manifest, output_manifest_path, pretty = TRUE, auto_unbox = TRUE)
  return(manifest)
}