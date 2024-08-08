#!/bin/bash
#$ -cwd
#$ -pe smp 4 -binding linear:4
#$ -l h_rt=2:00:00,h_vmem=25G,
# Define variable for job, to be stored in ${SGE_TASK_ID}


source /broad/software/scripts/useuse
reuse -q PLINK

datadir=$1
finalqc=${datadir}/final_preimp_qc
pop=$2
batch=$3


cd $finalqc
#cp $finalqc/${pop}_${batch}_unrel_qc_final* .

#reference: HRC
perl /stanley/huang_lab/home/ychen/software/HRC-1000G-check-bim/HRC-1000G-check-bim-NoReadKey.pl -b $finalqc/${pop}_${batch}_unrel_qc_final.bim -f $finalqc/${pop}_${batch}_unrel_qc_final-af.frq -l /home/unix/yu/software/00install_softwares/bin/plink -r /stanley/huang_lab/home/ychen/software/HRC-1000G-check-bim/HRC.r1-1.GRCh37.wgs.mac5.sites.tab -h
bash Run-plink.sh
/home/unix/yu/.conda/envs/yuenv/bin/parallel -j 10 /stanley/huang_lab/home/ychen/software/bcftools/bin/bcftools sort ${pop}_${batch}_unrel_qc_final-updated-chr{}.vcf -Oz -o  ${pop}_${batch}_unrel_qc_final-updated-chr{}.vcf.gz ::: {1..23}
/stanley/huang_lab/home/ychen/software/bcftools/bin/bcftools sort ${pop}_${batch}_unrel_qc_final-updated-chr23.vcf -Oz -o  ${pop}_${batch}_unrel_qc_final-updated-chr23.vcf.gz

rm *.vcf