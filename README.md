# sc-asia-array-QC
# QC Pipeline

## Sample QC
- **Sample-level call rate**: > 0.98
- **Remove samples that fail sex check**: `--check-sex`
- **Absolute value of autosomal heterozygosity rate deviating from the mean**: e.g., 3SD; `--het`
- **Identify unrelated individuals (Pi_hat < 0.2) within Asian samples**

## Variants QC
- **SNP-level call rate**: > 0.98
- **HWE**: > 1e-10
- **Retain only SNPs**: Excluding indels and monomorphic SNPs (for imputation; HRC: SNP only)
- **For chromosome X**:
  - Remove PAR region: The PARs are frequently removed because, although on the sex chromosomes, they do not behave as strictly X or Y regions.
  - Remove sex-specificity MAF SNPs: Variants are filtered if they have significantly different MAF between male and female controls.
  - Remove sex-specificity missingness SNPs: Variants are filtered if they have significantly different missingness between male and female controls.
  - Remove sex-assoc SNPs: Variants are filtered if they have significantly different minor allele frequency between male and female controls.

## Population Assignment
- **Select common, high-quality SNPs for population inference**:
  - SNP-level call rate > 0.98
  - Remove strand ambiguous SNPs and long-range LD regions (chr6:25-35Mb; chr8:7-13Mb inversion)
  - Prune to < 100K independent SNPs
  - Merge with 1KG reference

## Prepare Data for TopMed/Singapore 50k Imputation Server
- **Harmonize study data with HRC data**
- **Convert plink to vcf by chromosome**

## Send Unrelated European Samples to Michigan Server for Imputation
- **Chromosome X**:
  - Ploidy Check: Verifies if all variants in the nonPAR region are either haploid or diploid.
  - Mixed Genotypes Check: Verifies if the number of mixed genotypes (e.g., 1/.) is < 10 %.

## Post-imputation QC (Converting vcf dosages to plink hard-call genotypes)
- **INFO score/Imputation R2**: > 0.8
- **MAF (based on imputed dosages)**: > 1%
- **HWE**: > 1e-10
- **SNP-level call rate**: > 0.98

## Population Assignment Check
- **Select common, high-quality SNPs for population inference**:
  - SNP-level call rate > 0.98
  - Remove strand ambiguous SNPs and long-range LD regions (chr6:25-35Mb; chr8:7-13Mb inversion)
