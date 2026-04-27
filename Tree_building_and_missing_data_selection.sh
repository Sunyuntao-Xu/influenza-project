# PB1 AA tree
& "C:\iqtree-2.4.0-Windows\bin\iqtree2.exe" `
  -s "E:\influenza\China_UK_PB1_AA_aligned.fasta" `
  -st AA `
  -m MFP `
  -B 1000 `
  -alrt 1000 `
  -nt AUTO `
  -pre "E:\influenza\IQTREE_PB1_AA"


# WARNING: 48 sequences contain more than 50% gaps/ambiguity
# ****  TOTAL                                                                                23.14%  1 sequences failed composition chi2 test (p-value<5%; df=19)
# WARNING: Sequence A/Shanghai/1943/2019|EPI_ISL_365644|PB1|EPI1494886 contains only gaps or missing data
# WARNING: Sequence A/Llandeilo/1744/2022|EPI_ISL_15505097|PB1|EPI2197038 contains only gaps or missing data
# WARNING: Sequence A/Cornelly/7109/2022|EPI_ISL_15505736|PB1|EPI2197071 contains only gaps or missing data
# WARNING: Sequence A/Barry/9660/2019|EPI_ISL_350696|PB1|EPI1414716 contains only gaps or missing data
# WARNING: Sequence A/Wrexham/1126/2019|EPI_ISL_350699|PB1|EPI1414726 contains only gaps or missing data
# ERROR: Some sequences (see above) are problematic, please check your alignment again

# PB2 AA tree
& "C:\iqtree-2.4.0-Windows\bin\iqtree2.exe" `
  -s "E:\influenza\China_UK_PB2_AA_aligned.fasta" `
  -st AA `
  -m MFP `
  -B 1000 `
  -alrt 1000 `
  -nt AUTO `
  -pre "E:\influenza\IQTREE_PB2_AA"

# WARNING: 4 sequences contain more than 50% gaps/ambiguity
# ****  TOTAL                                                                                 0.25%  0 sequences failed composition chi2 test (p-value<5%; df=19)
# WARNING: Sequence A/Shanxi-Taiyuan/OFV3363/2024|EPI_ISL_19676903|PB2|EPI3818724 contains only gaps or missing data
# ERROR: Some sequences (see above) are problematic, please check your alignment again
