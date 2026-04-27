# Mutation point check for PB1
$positions = 12,57,151,154,200,211,317,336,353,364,386,396,397,454,527,587,667,719,757

foreach ($pos in $positions) {
    $outfile = "E:/pos_${pos}_check.tsv"

    seqkit subseq -r ${pos}:${pos} "E:\influenza\China_UK_PB1_AA_aligned.fasta" `
    | seqkit fx2tab > $outfile

    Write-Output "=== Position $pos ==="

    Import-Csv $outfile -Delimiter "`t" -Header "ID","AA" |
    Group-Object AA |
    Sort-Object Count -Descending |
    Select-Object Count, Name
}


# Mutation point check for PB2
$positions = 13,54,61,66,81,96,106,129,184,195,220,225,255,293,296,299,308,329,344,354,389,395,411,453,461,538,588,649,667,677,718,731

foreach ($pos in $positions) {
    $outfile = "E:/pos_${pos}_check.tsv"

    seqkit subseq -r ${pos}:${pos} "E:\influenza\China_UK_PB2_AA_aligned.fasta" `
    | seqkit fx2tab > $outfile

    Write-Output "=== Position $pos ==="

    Import-Csv $outfile -Delimiter "`t" -Header "ID","AA" |
    Group-Object AA |
    Sort-Object Count -Descending |
    Select-Object Count, Name
}
