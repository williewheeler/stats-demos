# http://datascienceplus.com/fitting-polynomial-regression-r/

p <- 0.5
q <- seq(0, 20, 1)
y <- 450 + p*(q-10)^3
plot(q, y, type="l", col="navy", main="Nonlinear relationship", lwd=3)
