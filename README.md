# Introduction

The **genease** project aims at finding druggable genes for a specific disease based on previously essayed targets. 
Whether these targets were successful or not is not the primary concern - the fact that there was enough evidence to try them is enough for us. 
In this way, we aim at mimicking the time-consuming task of proposing new reasonable targets. 

The suggestion of new disease genes uses data from [OpenTargets](https://www.opentargets.org/) as seed gene lists and the [STRING](https://string-db.org/) protein-protein interaction network to infer new genes. 

The project is almost entirely coded using [R](https://www.r-project.org/). 
Some [Matlab](https://www.mathworks.com/products/matlab.html) code has been necessary to include state of the art approaches.  

# Structure

The files and directories of this project are proceded by a number that indicates the chronological order of their execution. 
Scripts are stored in `Rmd` files. 
Their outputs are saved in folders sharing their prefix. 

# Reproducibility

### Metadata files

The output of `sessionInfo()` is always stored in the directory `00_metadata` to keep track of the package versions.

### Configuration files

There are configuration files, such as `03_config.R`, that contain a comprehensive amount of parameters, paths and file names.
Generally, these parameters are sourced instead of being hardcoded in the scripts.

### Package management

The project has package version control through `packrat` to ease portability between machines.

### External files

Almost all the files in the project are included in the git repository at the moment. 
Exceptions:

* STRING database files
* Network kernel(s)

The route of these files (Sergi's machines) can be found in the config files.

### Other

There are several `set.seed` calls throughout the code. 
Intermediate results are saved when the space required is not prohibitive. 

# Workflow 

### Data preprocessing

* Check OpenTargets data sanity
* Choose network: compromise between coverage and size
* Compute and store graph kernel on chosen network
* Save cleaned data, mapped to the network of choice

### Topology analysis

* Characterisation of disease genes in terms of network properties
* Within-disease study
* Between-disease study

### Performance

1. Load configuration files
2. Load dataset
3. Load network data
4. Build CV folds
5. Define functions for prediction
6. Define performance metrics
7. For each disease,input_type,fold
    
    1. Define train and validation
    2. Predict for every method using train
    3. Compute performance metrics
    4. Write to disk 
8. Plot metrics 
9. Build statistical models for comparing methods


# System requirements

### Hardware

The runs have been executed on the following hardware from the [UPC](http://www.upc.edu):

- *eko*: 

    - 12 threads (Intel(R) Xeon(R) CPU E7310@1.60GHz)
    - 32GB RAM
  
- *sun*:

    - 32 threads (Intel(R) Xeon(R) CPU E5-2450@2.10GHz)
    - 32GB RAM

### Code profiling
  
Running the script is *barely* possible with 16GB of RAM. 
We recommend using 32GB to avoid spikes with swapping.

For reference, executing all the diseases under a single repeated CV scheme (25 repetitions, 3 folds per repetition) on *eko* takes **one week**.

The code is a mixture between serial and parallel executions because not all the methods run in parallel.
