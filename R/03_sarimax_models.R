library(forecast)

fit_sarimax_model <- function(data, target_col = "price_php_kg", xreg_cols = NULL, seasonal_period = 52) {
  y <- ts(data[[target_col]], frequency = seasonal_period)
  
  if (!is.null(xreg_cols)) {
    xreg_matrix <- as.matrix(data[, xreg_cols])
    fit <- auto.arima(y, xreg = xreg_matrix, seasonal = TRUE, stepwise = FALSE, approximation = FALSE)
  } else {
    fit <- auto.arima(y, seasonal = TRUE, stepwise = FALSE, approximation = FALSE)
  }
  
  return(fit)
}

forecast_sarimax <- function(model_fit, h = 4, xreg_future = NULL) {
  if (!is.null(xreg_future)) {
    fc <- forecast(model_fit, xreg = as.matrix(xreg_future), h = h)
  } else {
    fc <- forecast(model_fit, h = h)
  }
  return(fc)
}