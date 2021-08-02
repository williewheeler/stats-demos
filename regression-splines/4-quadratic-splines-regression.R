# http://www.r-bloggers.com/splines-opening-the-black-box/

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

plot(cars)
reg=lm(dist~bs(speed,knots=c(K),degree=2),data=cars)
k=(K-min(cars$speed))/(max(cars$speed)-min(cars$speed))
u0=seq(0,1,by=.01)
v=reg$coefficients[1]+
  reg$coefficients[2]*B(u0,1,2,c(0,0,k,1,1,1))+
  reg$coefficients[3]*B(u0,2,2,c(0,0,k,1,1,1))+
  reg$coefficients[4]*B(u0,3,2,c(0,0,k,1,1,1))+
  reg$coefficients[5]*B(u0,4,2,c(0,0,k,1,1,1))
lines(min(cars$speed)+u0*(max(cars$speed)-min(cars$speed)), v,col="purple",lwd=2)
abline(v=K,lty=2,col="red")

print(summary(reg))
