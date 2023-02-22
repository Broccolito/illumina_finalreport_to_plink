library(R.utils)
library(data.table)
library(dplyr)

args = commandArgs(trailingOnly=TRUE)

report_filename = unlist(args)[1]
lgen_filename = unlist(strsplit(report_filename, split = "[.]"))[1]

cat("Loading Report file...\n")
final_report = fread(input = report_filename, skip = 9)
final_report = as.data.frame(final_report)

names(final_report) = c("sample_id", "snp_name", "gc_score", 
                        "allele1", "allele2",
                        "x", "y", "allele_freq", "log_r_ratio")

cat("Cleaning Report file...\n")
final_report = final_report %>%
  filter(allele1 != "I") %>%
  filter(allele2 != "I") %>%
  mutate(empty = "0") %>%
  mutate(fid = sample_id) %>%
  mutate(chr = sapply(snp_name, function(x){
    unlist(strsplit(x, split = "[:]"))[1]
  }) %>% unlist()) %>%
  mutate(chr = ifelse(chr %in% as.character(c(1:22, "X", "Y")), chr, "0"))
  
map = final_report %>%
  select(chr, snp_name, empty)

lgen = final_report %>%
  select(fid, sample_id, snp_name, allele1, allele2)

lgen = lgen[!duplicated(lgen),]
lgen = lgen[complete.cases(lgen),]
lgen = filter(lgen, allele1 != "-" & allele2 != "-")

fam = tibble(
  fid = final_report[["fid"]][1],
  sample_id = final_report[["sample_id"]][1],
  father_id = 0, 
  mother_id = 0,
  sex = 0,
  phenotype = -9
)

runner = paste0("plink --lfile ", lgen_filename, 
                " --allow-extra-chr --recode vcf --out ",
                lgen_filename, "_tovcf\n")

cat("Writing .map file...\n")
write.table(map, file = paste0(lgen_filename, ".map"),
            sep = "\t", col.names = F, row.names = F, quote = F)

cat("Writing .lgen file...\n")
write.table(lgen, file = paste0(lgen_filename, ".lgen"),
            sep = "\t", col.names = F, row.names = F, quote = F)

cat("Writing .fam file...\n")
write.table(fam, file = paste0(lgen_filename, ".fam"),
            sep = "\t", col.names = F, row.names = F, quote = F)

cat("Writing runner file ...\n")
writeLines(text = runner, con = paste0(lgen_filename, "_tovcf.sh"))

cat("Conversion Completed!\n")
  