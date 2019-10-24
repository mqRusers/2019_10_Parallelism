# 


# Declare out workload function
workload <- function (seed=0) {
  set.seed(seed)
  distribution <- runif(100e6)
  average <- mean(distribution)
  return(average)
} 


# make sure we have all the required packages installed

# if (!require(doParallel)) install.packages("doParallel")
# if (!require(foreach)) install.packages("foreach")

# load up our libraries
library(parallel)
library(doParallel)
library(foreach)

# How many CPU cores do we have available on our machine
numCores <- detectCores()

# Form a cluster with all available Cores
print(paste0("Creating Cluster (numCores=", numCores, ") ..."))
cl <- makeCluster(numCores, outfile="")

# Give our fresh cluster to DoParallel
registerDoParallel(cl)

print("Starting Parallel Loop ...")
system.time({
  foreach (seed=1:100) %dopar% {
    average <- workload(seed)
    print(seed)
  } 
})


print("Starting Parallel Apply ...")
system.time({
  results = mclapply(1:100, workload, mc.cores = numCores)
  #print(results)
})