# From Time Series Analysis and Its Applications
# Example 1.10

set.seed(819)

# 50 extra to avoid startup problems 
w <- rnorm(550, 0, 1)

# AR filter
# Just forcing the AR coefficients here, rather than fitting the model to the data.
# The [-(1:50)] removes the first 50 values from x.
x <- filter(w, filter=c(1.0, -0.9), method="recursive")[-(1:50)]

par(mfrow=c(2, 1))
plot.ts(w[-(1:50)], main="white noise")
plot.ts(x, main="autoregression")
