# Remove duplicate names

seqkit rmdup -n `
  -D "E:\influenza\PB1_NT_duplicate_names.txt" `
  "E:\influenza\China_UK_PB1_NT_aligned_trimmed.fasta" `
  -o "E:\influenza\China_UK_PB1_NT_aligned_trimmed_dedup.fasta"

# [INFO] 27 duplicated records removed

seqkit rmdup -n `
  -D "E:\influenza\PB2_NT_duplicate_names.txt" `
  "E:\influenza\China_UK_PB2_NT_aligned_trimmed.fasta" `
  -o "E:\influenza\China_UK_PB2_NT_aligned_trimmed_dedup.fasta"

# [INFO] 26 duplicated records removed


# PB1 NT tree
& "C:\iqtree-2.4.0-Windows\bin\iqtree2.exe" `
  -s "E:\influenza\China_UK_PB1_NT_aligned_trimmed_dedup.fasta" `
  -st DNA `
  -m MFP `
  -B 1000 `
  -alrt 1000 `
  -nt AUTO `
  -pre "E:\influenza\IQTREE_NT\IQTREE_PB1_NT_trimmed_dedup"


# PB2 NT tree
& "C:\iqtree-2.4.0-Windows\bin\iqtree2.exe" `
  -s "E:\influenza\China_UK_PB2_NT_aligned_trimmed_dedup.fasta" `
  -st DNA `
  -m MFP `
  -B 1000 `
  -alrt 1000 `
  -nt AUTO `
  -pre "E:\influenza\IQTREE_NT\IQTREE_PB2_NT_trimmed_dedup"
