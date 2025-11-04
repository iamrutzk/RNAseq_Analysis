# RNAseq_Analysis
Referenced based RNA-Sequencing: 
Aim:
1. The profiling of gene expression.
2. To analyze the change in cellular transcriptome.
3. To reveal the presence and quantity of RNA in sample.
4. Quantifying the differential gene expression.

At least you require two samples: 
a. Control: normal, healthy, not diseased 
b. Treated: abnormal, unhealthy, diseased

Biological analysis plan:
Control vs treated : check the expression of control with respect to treated
Treated vs control: check the expression of treated with respect to control
Control1 vs control2
Treated1 vs treated2

Three common steps in ngs:
	•	Library preparation 
	•	Sequencing
	•	Data analysis 

Tools installation 
By repositories method
	
  Fastqc: check the quality of data
sudo apt-get install fastqc 
 fastqc -help
	•	cutadapt tool- trimming the adapters
sudo apt-get install cutadapt
cutadapt -help
	•	hisat2 – mapping tool
sudo apt-get install hisat2
hisat2 
	•	samtools- convert sam to bam file or bam to sam 
sudo apt-get install samtools
samtools

By source code method : Cufflinks
Download cufflinks: http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz

Referenced based rna sequencing: reference genome is available in database for our sample with gtf file.
Replicates: to check the variability in the sample.
Two of replicates:
	•	Technical replicate: it means same experiment we are performing on sample again and again
	•	Biological replicate: we are taking different biological sample within same population
1. Depth: How many times the base is read by the sequencing machine.
2. Coverage: How many reads are able to cover the reference genome.
3. Phred quality score: It is assigned to each and every base which is sequenced by the machine. Every base which is sequenced by the machine has some quality score which tell us about the accuracy that how much accurately base was called by the machine.
Cutoff >=30 
4. Bam and sam file: Containing complete mapping information
5. Bam : Binary alignment map- computer readable file
6. Sam: sequence alignment file: Human readable file ATGACGTGCGA
7. Convert bam to sam or sam to bam – samtools
