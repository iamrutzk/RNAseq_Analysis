##Data selection
https://www.ncbi.nlm.nih.gov/sra/ERX11327741[accn]


##1. Data download
#control1
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR119/058/ERR11943458/ERR11943458.fastq.gz

#control2
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR119/059/ERR11943459/ERR11943459.fastq.gz

#Treated1
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR119/052/ERR11943452/ERR11943452.fastq.gz

#Treated2
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR119/053/ERR11943453/ERR11943453.fastq.gz

##cut the first 50 lakh reads

head -5000000 ERR11943458.fastq > control1_.fastq 
head -5000000 ERR11943459.fastq > control2_.fastq 
head -5000000 ERR11943452.fastq > Treated1_.fastq  
head -5000000 ERR11943453.fastq > Treated2_.fastq  

##2. Quality control

fastqc *.fastq

##3. Trimming and cleaning of data by using cutadapt
#for single end

cutadapt -b(seq) -q 30.30 -m 20 -o trim_control.fastq control1_.fastq

#for paired end 
cutadapt -b(seq) -B(seq) -q 30,30 -m 20 -o trim_control1_1.fastq -p trim_control1_2.fastq control1_1.fastq control1_2.fastq

#Download the chr16 from UCSC and annotation files

wget -c https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chr16.fa.gz

gunzip chr16.fa.gz

##4. Mapping 

#1. Creation of indexed genome

hisat2-build chr16.fa chr16

#2. Mapping of reads to indexed genome
#single end data

hisat2 --dta-cufflinks -p 2 -x chr16 control1.fastq > control1.bam

hisat2 --dta-cufflinks -p 2 -x chr16 control2.fastq > control2.bam

hisat2 --dta-cufflinks -p 2 -x chr16 Treated1.fastq > Treated1.bam

hisat2 --dta-cufflinks -p 2 -x chr16 Treated2.fastq > Treated2.bam

#Paired end data

hisat2 --dta-cufflinks -p 2 -x chr16 -1 sample_1.fastq -2 sample_2.fastq > mapped.bam

#3. Conversion of BAM into sorted BAM using samtools

Installation: sudo apt-get install samtools

samtools sort control1.bam > sorted_control1.bam
samtools sort control2.bam > sorted_control2.bam
samtools sort Treated1.bam > sorted_Treated1.bam
samtools sort Treated2.bam > sorted_Treated2.bam

##4: to normalise the data and count no. of reads

cufflinks -o cufflinks_control1 -p 2 -G chr16.gtf sorted_control1.bam

cufflinks -o cufflinks_control2 -p 2 -G chr16.gtf sorted_control2.bam

cufflinks -o cufflinks_Treated1 -p 2 -G chr16.gtf sorted_Treated1.bam

cufflinks -o cufflinks_Treated2 -p 2 -G chr16.gtf sorted_Treated2.bam

##6: Merging

cuffmerge -o cuffmerge_output -p 2 -g chr16.gtf -s chr16.fa assembly.txt

##7: Differential expression using cuffdiff
#plan
#Treated vs control

cuffdiff -p 2 -o cuffdiff_result -L control,Treated -u /mnt/f/Dr_OmicsLab/NGS/RNAseq_Human/cuffmerge_output/merged.gtf sorted_control1.bam,sorted_control2.bam sorted_Treated1.bam,sorted_Treated2.bam


#Steps for post analysis
Load gene expression file from cuffdiff output to excel and filter out the following.
1.sorting of significant genes: filter pvalue <0.05, log fold - up = >=1, down= <=-1 Do conditional formatting. And also separate gene name with comma, and add them on original sheet.
Go to uniprot - select ID mapping and paste all the short listed genes there.
customize the column - then add the columns - in gene ontology select all and from external resources select genome annotation - select gene id, Kegg etc..  and download it in excel format.
2.gene annotation: Load the downloaded file and name it gene annotation, Remove the duplicates and copy and paste it in the gene expression file with significant genes and compare the IDs with gene and from NM IDs. 
3.Pathway enrichment: functional enrichment: Go to ShinyGo website and paste the gene names there, and get min 10 to max 5000 pathways. Check with all parameters kegg, gene ontology etc.. and you will get some plots etc check and study each accordingly.
4.network analysis: to go the STRING database - now add the separate excel sheet which have only log(fold Change) and gene name. And now copy the genes and paste them in string database. And download the nodes in tsv file. And Now download Cytoscape and upload this file and visualize the data.
5.R plot : volcano plot, heatmap plot 






