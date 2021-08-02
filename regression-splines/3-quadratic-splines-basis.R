# http://www.r-bloggers.com/splines-opening-the-black-box/

# Example: basis functions with two knots

library(splines)

# x = x values
# j = knot index
# n = degree
# K = knots
B = function(x,j,n,K) {
  b=0
  a1=a2=0
  if(((K[j+n+1]>K[j+1])&(j+n<=length(K))&(n>0))==TRUE) {
    a2=(K[j+n+1]-x)/(K[j+n+1]-K[j+1])*B(x,j+1,n-1,K)
  }
  if(((K[j+n]>K[j])&(n>0))==TRUE) {
    a1=(x-K[j])/(K[j+n]-K[j])*B(x,j,n-1,K)
  }
  if(n==0) {
    b=((x>K[j])&(x<=K[j+1]))*1
  }
  if(n>0) {
    b=a1+a2
  }
  return(b)
}

# Knots
K = c(14, 20)

# distance to stop vs speed
plot(cars)

# bs = B-spline basis for polynomial splines
reg = lm(dist ~ bs(speed, knots=c(K), degree=2), data=cars)

u = seq(0, 1, by=0.01)
plot(u,B(u,1,2,c(0,0,.4,.7,1,1,1)),lwd=2,col="red",type="l",ylim=c(0,1))
lines(u,B(u,2,2,c(0,0,.4,.7,1,1,1)),lwd=2,col="blue")
lines(u,B(u,3,2,c(0,0,.4,.7,1,1,1)),lwd=2,col="green")
lines(u,B(u,4,2,c(0,0,.4,.7,1,1,1)),lwd=2,col="orange")

# Vertical dashed lines to show where the knots are
abline(v=c(0,.4,.7,1), lty=2)
