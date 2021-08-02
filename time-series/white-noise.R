# From Time Series Analysis and Its Applications
# Examples 1.8, 1.9

set.seed(819)

# 500 N(0, 1) variates
w <- rnorm(500, 0, 1)

# MA filter
v <- filter(w, filter=rep(1/3, 3), sides=2)

par(mfrow=c(2, 1))
plot.ts(w, main="white noise")
plot.ts(v, main="moving average")
