cd E:\influenza

Get-Content China_PB1_NT.fasta, UK_PB1_NT.fasta | Set-Content China_UK_PB1_NT.fasta

Get-Content China_PB2_NT.fasta, UK_PB2_NT.fasta | Set-Content China_UK_PB2_NT.fasta

# Remove problematic sequences based on length
seqkit seq -m 2000 -M 2341 China_UK_PB1_NT.fasta -o China_UK_PB1_NT_lenfiltered.fasta
seqkit stats China_UK_PB1_NT.fasta China_UK_PB1_NT_lenfiltered.fasta

seqkit seq -m 2000 -M 2341 China_UK_PB2_NT.fasta -o China_UK_PB2_NT_lenfiltered.fasta
seqkit stats China_UK_PB2_NT.fasta China_UK_PB2_NT_lenfiltered.fasta


# PS E:\influenza> seqkit stats China_UK_PB1_NT.fasta China_UK_PB1_NT_lenfiltered.fasta
# processed files:  2 / 2 [======================================] ETA: 0s. done
# file                               format  type  num_seqs     sum_len  min_len  avg_len  max_len
# China_UK_PB1_NT.fasta              FASTA   DNA      6,443  14,633,015      479  2,271.1    2,744
# China_UK_PB1_NT_lenfiltered.fasta  FASTA   DNA      6,337  14,464,828    2,201  2,282.6    2,377

# PS E:\influenza>
# PS E:\influenza> seqkit stats China_UK_PB2_NT.fasta China_UK_PB2_NT_lenfiltered.fasta
# processed files:  2 / 2 [======================================] ETA: 0s. done
# file                               format  type  num_seqs     sum_len  min_len  avg_len  max_len
# China_UK_PB2_NT.fasta              FASTA   DNA      6,441  14,730,472      746    2,287    3,013
# China_UK_PB2_NT_lenfiltered.fasta  FASTA   DNA      6,391  14,626,311    2,205  2,288.6    2,371
