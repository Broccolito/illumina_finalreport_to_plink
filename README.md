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



### Install Plink

Make sure that plink1.9 or plink2.0 is installed and can be executed by the ```plink [args]``` command.



## Run Example

### Run R script

```bash
Rscript report_to_lgen.R example_final_report.txt
```

Alternatively, the final report file can be in the .txt.gz format:

```bash
Rscript report_to_lgen.R example_final_report.txt.gz
```

This command generates four files:

- .fam file
- .map file
- .lgen file
- .sh runner file



### Run the bash script generated

In terminal, execute the bash script to convert the .lgen file set to .vcf file

```bash
bash example_final_report_tovcf.sh
```

Alternatively, run this plink command in the terminal:

```bash
plink --lfile example_final_report --allow-extra-chr --recode vcf --out example_final_report_tovcf
```





