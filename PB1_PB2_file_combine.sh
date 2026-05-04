cd E:\influenza

Get-Content China_PB1_NT.fasta, UK_PB1_NT.fasta | Set-Content China_UK_PB1_NT.fasta

Get-Content China_PB2_NT.fasta, UK_PB2_NT.fasta | Set-Content China_UK_PB2_NT.fasta

# Remove problematic sequences based on length
seqkit seq -m 2000 -M 2400 China_UK_PB1_NT.fasta -o China_UK_PB1_NT_lenfiltered.fasta
seqkit stats China_UK_PB1_NT.fasta China_UK_PB1_NT_lenfiltered.fasta

seqkit seq -m 2000 -M 2400 China_UK_PB2_NT.fasta -o China_UK_PB2_NT_lenfiltered.fasta
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

# PB1: 6443 → 6337   removed 106 sequences
# PB2: 6441 → 6391   removed 50 sequences



# Remove sequences with more than 10% N

# PB1
seqkit fx2tab China_UK_PB1_NT_lenfiltered.fasta |
  ForEach-Object {
    $cols = $_ -split "`t"
    $name = $cols[0]
    $seq  = $cols[1].ToUpper()

    $nCount = ([regex]::Matches($seq, "N")).Count
    $nProp  = $nCount / $seq.Length

    if ($nProp -le 0.10) {
      "$name`t$seq"
    }
  } |
  seqkit tab2fx -o China_UK_PB1_NT_len_N10_filtered.fasta


# PB2
seqkit fx2tab China_UK_PB2_NT_lenfiltered.fasta |
  ForEach-Object {
    $cols = $_ -split "`t"
    $name = $cols[0]
    $seq  = $cols[1].ToUpper()

    $nCount = ([regex]::Matches($seq, "N")).Count
    $nProp  = $nCount / $seq.Length

    if ($nProp -le 0.10) {
      "$name`t$seq"
    }
  } |
  seqkit tab2fx -o China_UK_PB2_NT_len_N10_filtered.fasta


seqkit stats China_UK_PB1_NT_lenfiltered.fasta China_UK_PB1_NT_len_N10_filtered.fasta
seqkit stats China_UK_PB2_NT_lenfiltered.fasta China_UK_PB2_NT_len_N10_filtered.fasta


# Remove invalid sequence code
seqkit replace -s -p "[^ACGTNacgtn]" -r "N" China_UK_PB1_NT_len_N10_filtered.fasta -o China_UK_PB1_NT_lenfiltered_clean.fasta

seqkit replace -s -p "[^ACGTNacgtn]" -r "N" China_UK_PB2_NT_len_N10_filtered.fasta -o China_UK_PB2_NT_lenfiltered_clean.fasta
