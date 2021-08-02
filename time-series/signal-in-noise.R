# From Time Series Analysis and Its Applications
# Example 1.12

set.seed(819)
cs <- 2*cos(2*pi*1:500/50+0.6*pi)
w <- rnorm(500, 0, 1)
par(mfrow=c(3, 1), mar=c(3, 2, 2, 1), cex.main=1.5)
plot.ts(cs, main=expression(2*cos(2*pi*t/50+0.6*pi)))
plot.ts(cs+w, main=expression(2*cos(2*pi*t/50+0.6*pi) + N(0, 1)))
plot.ts(cs+5*w, main=expression(2*cos(2*pi*t/50+0.6*pi) + N(0, 25)))
