# http://www.r-bloggers.com/splines-opening-the-black-box/

library(splines)

# Knots
K = c(14, 20)

# distance to stop vs speed
plot(cars)

# bs = B-spline basis for polynomial splines
reg = lm(dist ~ bs(speed, knots=c(K), degree=2), data=cars)

u = seq(4, 25, by=.1)
B = data.frame(speed=u)
Y = predict(reg, newdata=B)
lines(u, Y, lwd=2, col="red")
print(summary(reg))
