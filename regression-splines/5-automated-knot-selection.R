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

vk=seq(.05,.95,by=.05)

# sum of squared residuals
SSR=matrix(NA,length(vk))
for (i in 1:(length(vk))) {
  k=vk[i]
  K=min(cars$speed)+k*(max(cars$speed)-min(cars$speed))
  reg=lm(dist~bs(speed,knots=c(K),degree=2),data=cars)
  SSR[i]=sum(residuals(reg)^2)
}

# This shows that SSR is minimized at 0.75
plot(vk,SSR,type="b",col="blue")

print(summary(reg))
