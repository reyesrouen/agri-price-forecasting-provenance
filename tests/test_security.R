library(testthat)

# Load scripts using project-root relative paths
source(here::here("R/01_manifest_gen.R"))
source(here::here("R/02_verification_gate.R"))

test_that("Verification gate catches tampered data", {
  keys <- generate_keypair()
  temp_data <- tempfile(fileext = ".csv")
  temp_manifest <- tempfile(fileext = ".json")
  
  writeLines("date,price\n2026-01-01,200", temp_data)
  create_data_manifest(temp_data, keys$private, temp_manifest)
  
  # Tamper with dataset
  writeLines("date,price\n2026-01-01,999", temp_data)
  
  expect_error(verify_data_integrity(temp_data, temp_manifest, keys$public), "SECURITY HALT")
})