# illumina Final Report to Plink
This repository provides tools to convert illumina final report files to plink-readable files



## Setup

### Clone the GitHub repository

```bash
git clone https://github.com/Broccolito/illumina_finalreport_to_plink
cd illumina_finalreport_to_plink/
```



### Run the setup script to download all the R libraries required

```bash
Rscript setup.R
```



Alternatively, in R, run:

```R
if(!require("R.utils")){
  install.packages("R.utils")
  library("R.utils")
}

if(!require("data.table")){
  install.packages("data.table")
  library("data.table")
}

if(!require("dplyr")){
  install.packages("dplyr")
  library("dplyr")
}
```



Alternatively, make sure that the "R.utils", "data.table" and "dplyr" packages are installed in the R environment (or in the conda environment) before proceeding to the next step.



