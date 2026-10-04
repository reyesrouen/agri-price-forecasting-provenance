library(prophet)
library(dplyr)

fit_prophet_model <- function(data, date_col = "date", target_col = "price_php_kg", regressor_cols = NULL) {
  df <- data %>%
    rename(ds = !!sym(date_col), y = !!sym(target_col)) %>%
    mutate(ds = as.Date(ds))
  
  m <- prophet(weekly.seasonality = TRUE, yearly.seasonality = TRUE)
  
  if (!is.null(regressor_cols)) {
    for (reg in regressor_cols) {
      m <- add_regressor(m, reg)
    }
  }
  
  m <- fit.prophet(m, df)
  return(m)
}

forecast_prophet <- function(model_fit, future_df) {
  predict(model_fit, future_df)
}