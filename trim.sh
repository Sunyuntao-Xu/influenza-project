cd E:\influenza

# PB2: trim aligned columns 51 to 2400
seqkit subseq -r 51:2400 China_UK_PB2_NT_aligned.fasta -o China_UK_PB2_NT_aligned_trimmed.fasta

# PB1: trim aligned columns 45 to 2400
seqkit subseq -r 45:2400 China_UK_PB1_NT_aligned.fasta -o China_UK_PB1_NT_aligned_trimmed.fasta

# PA: trim aligned columns 45 to 2400
seqkit subseq -r 45:2400 China_UK_PB1_NT_aligned.fasta -o China_UK_PB1_NT_aligned_trimmed.fasta

seqkit stats China_UK_PB2_NT_aligned.fasta China_UK_PB2_NT_aligned_trimmed.fasta

seqkit stats China_UK_PB1_NT_aligned.fasta China_UK_PB1_NT_aligned_trimmed.fasta
