# From Time Series Analysis and Its Applications
# Example 1.11

set.seed(819)
w <- rnorm(200, 0, 1)
x <- cumsum(w)
wd <- w + 0.2
xd <- cumsum(wd)
par(mfrow=c(1, 1))
plot.ts(xd, ylim=c(-5, 55), main="random walk")
lines(x)
lines(0.2 * (1:200), lty="dashed")
