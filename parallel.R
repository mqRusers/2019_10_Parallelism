#
#  _____         ______                      _  _        _    
# |  __ \        | ___ \                    | || |      | |   
# | |  \/  ___   | |_/ /  __ _  _ __   __ _ | || |  ___ | |   
# | | __  / _ \  |  __/  / _` || '__| / _` || || | / _ \| |   
# | |_\ \| (_) | | |    | (_| || |   | (_| || || ||  __/| | _ 
#  \____/ \___/  \_|     \__,_||_|    \__,_||_||_| \___||_|( )
#                                                          |/ 
#  _____         ______              _                        
# |  __ \        |  ___|            | |                       
# | |  \/  ___   | |_     __ _  ___ | |_   ___  _ __          
# | | __  / _ \  |  _|   / _` |/ __|| __| / _ \| '__|         
# | |_\ \| (_) | | |    | (_| |\__ \| |_ |  __/| |            
# \____/  \___/  \_|     \__,_||___/ \__| \___||_|      
# 


# We'll need at least the parallel libray
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