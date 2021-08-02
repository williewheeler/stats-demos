library(markovchain)
library(diagram)

lad.states <- c('Drinking', 'Sightseeing', 'Kayaking', 'Hiking')
lad.transitions <- matrix(
  c(0.4, 0.6, 0.0, 0.0, 0.2, 0.0, 0.0, 0.8, 0.1, 0.0, 0.7, 0.2, 0.3, 0.0, 0.2, 0.5),
  nrow=4, byrow=F, dimnames=list(lad.states, lad.states)
)
lad.transitions

plotmat(lad.transitions, pos=c(2, 2), self.cex=0.5, shadow.size=0)

lad.mc <- new(
  'markovchain', states=lad.states, byrow=T,
  transitionMatrix=lad.transitions, name='A Lad'
)
steadyStates(lad.mc)
