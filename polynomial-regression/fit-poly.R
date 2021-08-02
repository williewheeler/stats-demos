# http://datascienceplus.com/fitting-polynomial-regression-r/

set.seed(20)

q <- seq(from=0, to=20, by=0.1)
y <- 500 + 0.4 * (q-10)^3
noise <- rnorm(length(q), mean=10, sd=80)
noisy.y <- y + noise
plot(q, noisy.y, col="deepskyblue4", xlab="q", main="Observed data")
lines(q, y, col="firebrick1", lwd=3)

# Cubic fit
model <- lm(noisy.y ~ poly(q, 3))

model.summary <- summary(model)
model.confint <- confint(model, level=0.95)

print("MODEL SUMMARY:")
print(model.summary)

print("CONFIDENCE INTERVALS FOR MODEL PARAMS:")
print(model.confint)

# This shows that the residuals are independent of the fitted model.
# Note that there's more density around x=500 since there are a lot of data
# points there.
#dev.new()
#plot(fitted(model), residuals(model))

predicted.intervals <-
  predict(model, data.frame(x=q), interval="confidence", level=0.99)

# Add the fit, along with upper and lower bounds
lines(q, predicted.intervals[,1], col="green", lwd=3) # fit
lines(q, predicted.intervals[,2], col="green", lwd=1) # lower bound
lines(q, predicted.intervals[,3], col="green", lwd=1) # upper bound

legend("bottomright", c("Observed", "Signal", "Predicted"),
  col=c("deepskyblue4", "red", "green"), lwd=3)
