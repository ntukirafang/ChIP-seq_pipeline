source /applications/Anaconda3/2024.10/etc/profile.d/conda.sh
conda activate base
module load SAMtools
module load deepTools
module load MACS2
module load Bowtie2

# Align ChIP
#bowtie2 --threads 4 -x ${ref} \
#    -1 ${fastq_chip}/${srr_ChIP}_R1_001.fastq.gz \
#    -2 ${fastq_chip}/${srr_ChIP}_R2_001.fastq.gz \
#    -S ${bam}/${name_ChIP}.sam

# Align Input
#bowtie2 --threads 4 -x ${ref} \
#    -1 ${fastq_input}/${srr_Input}_R1_001.fastq.gz \
#    -2 ${fastq_input}/${srr_Input}_R2_001.fastq.gz \
#    -S ${bam}/${name_Input}.sam

# Clean BAM (ChIP)
#samtools view -uf 0x2 ${bam}/${name_ChIP}.sam | \
#    samtools sort -n -@ 4 -o ${bam2}/${name_ChIP}.namesort.bam
#samtools fixmate -m ${bam2}/${name_ChIP}.namesort.bam ${bam2}/${name_ChIP}.fixmate.bam
#samtools sort -o ${bam2}/${name_ChIP}.positionsort.bam ${bam2}/${name_ChIP}.fixmate.bam
#samtools markdup -r -s ${bam2}/${name_ChIP}.positionsort.bam ${bam2}/${name_ChIP}.rmdup.bam
#samtools index ${bam2}/${name_ChIP}.rmdup.bam

# Clean BAM (Input)
#samtools view -uf 0x2 ${bam}/${name_Input}.sam | \
#    samtools sort -n -@ 4 -o ${bam2}/${name_Input}.namesort.bam
#samtools fixmate -m ${bam2}/${name_Input}.namesort.bam ${bam2}/${name_Input}.fixmate.bam
#samtools sort -o ${bam2}/${name_Input}.positionsort.bam ${bam2}/${name_Input}.fixmate.bam
#samtools markdup -r -s ${bam2}/${name_Input}.positionsort.bam ${bam2}/${name_Input}.rmdup.bam
#samtools index ${bam2}/${name_Input}.rmdup.bam
#rm ${bam}/${name_Input}.sam
#rm ${bam}/${name_ChIP}.sam

# BigWig (optional)
#bamCoverage --extendReads --normalizeUsing CPM --binSize 5 \
#    --blackListFileName ${blacklist} \
#    -b ${bam2}/${name_ChIP}.rmdup.bam \
#    -o ${bw}/${name_ChIP}.bw

# Peak calling with input control
macs2 callpeak -f BAMPE -g mm --keep-dup all -t ${bam2}/${name_ChIP}.rmdup.bam \
    -c ${bam2}/${name_Input}.rmdup.bam \
    --outdir ${peaks} -n ${name_ChIP}
