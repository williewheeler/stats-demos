# Code from
# NHPoisson: An R Package for Fitting and Validating Nonhomogeneous Poisson Processes
# by Ana C. Cebrián, Jesús Abaurrea and Jesús Asín.

library("NHPoisson")
data("BarTxTn", package = "NHPoisson")

# ==============================================================================
# 5.2 Data preparation
# ==============================================================================

# Date of each observation
dateB <- cbind(BarTxTn$ano, BarTxTn$mes, BarTxTn$diames)

# The object BarEv several characteristics of the 137 EHEs, such as Px, the points of maximum intensity in the extreme events,
# which are the occurrence points of the process. Another element of the object is the index inddat, which marks the observations
# to be used in the estimation process,
BarEv <- POTevents.fun(T = BarTxTn$Tx, thres = 318, date = dateB)
Px <- BarEv$Px
inddat <- BarEv$inddat

tBPx <- BarTxTn$ano + rep(c(0:152) / 153,55)
emplambdaB <- emplambda.fun(posE = Px, inddat = inddat, t = tB, lint = 153, tit = "Barcelona")

# ==============================================================================
# 5.3 Fitting the model
# ==============================================================================

mod1Bind <- fitPP.fun(covariates = NULL, posE = BarEv$Px, inddat = BarEv$inddat, tit = "BAR  Intercept", start = list(b0 = 1))
covB <- cbind(cos(2 * pi * BarTxTn$dia / 365), sin(2 * pi * BarTxTn$dia / 365),  BarTxTn$Txm31, BarTxTn$Tnm31, BarTxTn$TTx, BarTxTn$TTn)
dimnames(covB) <- list(NULL, c("Cos", "Sin", "Txm31",  "Tnm31", "TTx", "TTn"))
aux <- stepAICmle.fun(ImlePP = mod1Bind, covariatesAdd = covB, startAdd = c(1, -1, 0, 0, 0, 0), direction = "both")

# We start by fitting a HPP
modB.1 <- fitPP.fun(covariates = NULL, posE  = Px, inddat = inddat, tit = "BARCELONA Tx; Intercept", start = list(b0 = 1), dplot = FALSE, modCI = FALSE)

# The following commands analyze if the first order harmonic terms must be included,
covB <- cbind(cos(2 * pi * BarTxTn$dia / 365), sin(2 * pi * BarTxTn$dia / 365))
modB.2 <- fitPP.fun(covariates = covB, posE = Px, inddat = inddat, tit = "BARCELONA Tx; Cos, Sin", start = list(b0 = -100, b1 = 1, b2 = 1), modSim = TRUE,  dplot = FALSE, modCI = FALSE)
aux <- testlik.fun(ModG = modB.2, ModR = modB.1)

# Since the p value is 0, the first order harmonic is included and the inclusion of the second order harmonic is checked.
covB <- cbind(cos(2 * pi * BarTxTn$dia / 365), sin(2 * pi * BarTxTn$dia / 365), cos(4 * pi * BarTxTn$dia / 365),  sin(4 * pi * BarTxTn$dia / 365))
modB.3 <- fitPP.fun(covariates = covB, posE = Px, inddat = inddat, tit = "BARCELONA Tx; Cos, Sin, Cos2, Sin2", start = list(b0 = -100, b1 = 1, b2 = 1, b3 = 1, b4 = 1),  modSim = TRUE, dplot = FALSE, modCI = FALSE)
aux <- testlik.fun(ModG = modB.3, ModR = modB.2)

covB.final <- cbind(cos(2 * pi * BarTxTn$dia / 365), sin(2 * pi * BarTxTn$dia / 365), BarTxTn$Txm31)
dimnames(covB.final) <- list(NULL, c("Cos", "Sin", "Txm31"))
modB.final <- fitPP.fun(covariates = covB.final,  posE = Px, inddat = inddat,  tim = tB, tit = "BARCELONA Tx; Cos, Sin, Txm31", start = list(b0 = -100, b1 = 1, b2 = 1, b3 = 0))

aux <- LRTpv.fun(modB.final)
summary(modB.final)
confint(modB.final)
confintAsin.fun(modB.final)

# ==============================================================================
# 5.4 Model validation
# ==============================================================================

posEHB <- transfH.fun(modB.final)$posEH
resB <- unifres.fun(posEHB)
graphresU.fun(unires = resB$unires, posE = modB.final@posE, Xvariables = cbind(covB.final, BarTxTn$dia), namXv = c("cos", "sin", "Txm31", "summer day index"), tit = "BARCELONA; cos, sin, Txm31", addlow = FALSE)

ResDB <- CalcResD.fun(mlePP = modB.final, lint = 153)

qqnorm(ResDB$RawRes)

graphrate.fun(ResDB, tit = "BARCELONA; cos, sin, Txm31")

covBtemp <- cbind(BarTxTn$Txm31, BarTxTn$TTx)
aux <- graphResCov.fun(mlePP = modB.final, nint = 50, X = covBtemp, namX = c("Txm31", "TTx"), tit = "BARCELONA; cos, sin, Txm31", typeRes = "Raw")

graphres.fun(objres = ResDB, typeRes = "Pearson", addlow = TRUE, plotDisp = c(1, 1), tit = "BARCELONA; cos, sin, Txm31")
aux <- resQQplot.fun(nsim = 100, objres = ResDB,  covariates = covB.final, tit = "BARCELONA; cos, sin, Txm31", fixed.seed = 123)

# All the previous analysis can be obtained in one step using the globalval.fun,
aux <- globalval.fun(mlePP = modB.final, lint = 153, typeI = "Disjoint", typeResLV = "Raw", nintLP = 50, tit = "BARCELONA; cos, sin, Txm31",  Xvar = covBtemp, namXvar = c("Txm31", "TTx"), resqqplot = TRUE, fixed.seed = 123)

# ==============================================================================
# 5.5 Simulation based inference
# ==============================================================================
