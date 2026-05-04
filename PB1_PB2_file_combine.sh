cd E:\influenza

Get-Content China_PB1_NT.fasta, UK_PB1_NT.fasta | Set-Content China_UK_PB1_NT.fasta

Get-Content China_PB2_NT.fasta, UK_PB2_NT.fasta | Set-Content China_UK_PB2_NT.fasta

# Remove problematic sequences based on length
seqkit seq -m 2000 -M 2341 China_UK_PB1_NT.fasta -o China_UK_PB1_NT_lenfiltered.fasta
seqkit stats China_UK_PB1_NT.fasta China_UK_PB1_NT_lenfiltered.fasta

seqkit seq -m 2000 -M 2341 China_UK_PB2_NT.fasta -o China_UK_PB2_NT_lenfiltered.fasta
seqkit stats China_UK_PB2_NT.fasta China_UK_PB2_NT_lenfiltered.fasta
