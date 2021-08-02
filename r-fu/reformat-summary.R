# Love this demonstration of how to reformat R's data frame summary.
# http://stackoverflow.com/questions/40038881/formatting-r-output

tmp <- data.frame(
  var1 = runif(100, min = 5, max = 50),
  var2 = c(runif(99, min = 50, max = 150), NA),
  var3 = runif(100, min = 150, max = 250)
)

tmp <- as.data.frame(t(do.call(cbind, lapply(tmp, function(x) {
  # save summary information
  v <- as.vector(summary(x))
  # if vector has no NAs, manually add 0, to ensure equal 
  # length of vectors for column bind
  if (length(v) < 7) v <- c(v, 0)
  # return summary
  v
}))))

colnames(tmp) <- c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max.", "NA's")

# result so far:
##         Min. 1st Qu. Median   Mean 3rd Qu.   Max. NA's
## var1   5.097   15.12  26.83  26.46   36.89  49.75    0
## var2  50.900   83.08 104.50 103.80  129.00 149.20    1
## var3 151.200  166.80 200.30 197.00  223.70 248.50    0
