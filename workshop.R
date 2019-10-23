#
# 2019_10_Parallelism
#

# Let's create some articifal work using R's Random Uniform Distribution function "runif(x)"


distribution <- runif(10)
average <- mean(distribution)
print(average)
barplot(distribution)

# now let's set the SEED to get predictable numbers
set.seed(12345678)
distribution <- runif(10)
average <- mean(distribution)
print(average)
barplot(distribution)

# And lets create more work (scaling up)
{
set.seed(87654321)
distribution <- runif(100)
average <- mean(distribution)
print(average)
barplot(distribution)
}

# and how long is that exactly ?
system.time({
  set.seed(12345678)
  distribution <- runif(100e6)
  average <- mean(distribution)
  print(average)
})


# Let's wrap this up in a function for our later tests
workload <- function (seed=0) {
  set.seed(seed)
  distribution <- runif(100e6)
  average <- mean(distribution)
  return(average)
} 

# It should give the same result - so let's check
workload(12345678)

# and take almost the same time to run
system.time({
  print(workload(12345678))
})


# Most scientific compute task involve doing similar things over and over.
# Let's simulate this by computing averages for 10 different SEEDs

workload(1)
workload(2)
workload(3)
workload(4)
workload(5)
workload(6)
workload(7)
workload(8)
workload(9)
workload(10)

# or of course we could use a FOR loop ...
for (seed in 1:10) {
  average <- workload(seed)
  print(average)
}

# and we could APPLY the workload function to an array of SEEDs
lapply(1:10, workload)

# but which one is faster, loops ...
system.time({
  for (seed in 1:10) {
    average <- workload(seed)
    print(average)
  }
})

# or applying ?
system.time({
  print(lapply(1:10, workload))
})


# Now we go parallel to go faster ...
library(parallel)

# How many CPU cores do we have available on our machine
detectCores()
numCores <- detectCores()


# Let try it with a parallel loop

install.packages("doParallel")
library(doParallel)
library(foreach)

cl <- makeCluster(numCores/2)
registerDoParallel(cl)

system.time({
  foreach (seed=1:10) %dopar% {
    average <- workload(seed)
    print(average)
  } 
})

# and similarly we can do a parallel APPLY
system.time({
  results = mclapply(1:10, workload, mc.cores = numCores)
})
