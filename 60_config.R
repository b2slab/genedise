#################################
# dataset and database
#################################

# reproducibility
dir_metadata <- "00_metadata"

# abbreviations
file_abbrev <- "60_abbreviations.R"
# color palettes
# see http://tools.medialab.sciences-po.fr/iwanthue/
file_palette25 <- "60_palette25.txt"

#################################
# output directories
#################################


# performance metrics
dir_models <- "63_models"
dir_boxplots <- "63_boxplots"

# Analysis of the topology and the positives
dir_boxplots <- "63_boxplots"
dir_contrasts <- "63_contrasts"


#################################
# Hostnames
#################################

# get the host name (linux)
# our machines at UPC are "eko" and "sun"
host <- Sys.info()["nodename"]
print(paste("You are running the CV on the host:", host))

# options for each machine
# - number of threads to use
# - cv schemes to run (each cv produces its own file, 
#     outputs can be combined later between machines). 
#     Order matters!
#     
# If you want to add your own machines, you can do so by 
# appending more options with their hostnames
nslaves <- parallel::detectCores()
