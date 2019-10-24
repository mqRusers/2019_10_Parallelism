# Now we go parallel to go faster ...
library(parallel)

# How many CPU cores do we have available on our machine
detectCores()
numCores <- detectCores()

# Let try it with a parallel loop

install.packages("doParallel")
library(doParallel)
library(foreach)

cl <- makeCluster(numCores)
registerDoParallel(cl)

system.time({
  result <- c()
  foreach (seed=1:10) %dopar% {
    result[seed] <- workload(seed)
    print(average)
  } 
  print(result)
})

# and similarly we can do a parallel APPLY
system.time({
  results = mclapply(1:10, workload, mc.cores = numCores)
})