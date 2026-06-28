###############################################################################
# Prepare PB1, PB2 and PA nucleotide FASTA files for phylogenetic analysis
#
# Steps:
#   1. Merge China and UK FASTA files for each segment
#   2. Remove gaps and filter by expected segment length
#   3. Replace invalid nucleotide characters with N
#   4. Remove sequences with >10% N
#   5. Report sequence statistics after each major step
#
# Requirements:
#   - seqkit installed and available in PATH
#   - Input FASTA files stored in E:\influenza
#
# Author: Sunyuntao Xu
###############################################################################


# ----------------------------- User settings ---------------------------------

$WorkDir = "E:\influenza"

# Segment-specific settings
# PB1 and PB2 are expected to be around 2.3 kb.
# PA is shorter, expected to be around 2,233 bp.
$Segments = @(
    @{
        Name      = "PB1"
        ChinaFile = "China_PB1_NT.fasta"
        UKFile    = "UK_PB1_NT.fasta"
        MinLen    = 2000
        MaxLen    = 2400
    },
    @{
        Name      = "PB2"
        ChinaFile = "China_PB2_NT.fasta"
        UKFile    = "UK_PB2_NT.fasta"
        MinLen    = 2000
        MaxLen    = 2400
    },
    @{
        Name      = "PA"
        ChinaFile = "China_PA_NT.fasta"
        UKFile    = "UK_PA_NT.fasta"
        MinLen    = 2100
        MaxLen    = 2350
    }
)

# Maximum allowed proportion of ambiguous nucleotides
$MaxNProp = 0.10


# ----------------------------- Start script ----------------------------------

Set-Location $WorkDir

Write-Host "Working directory: $WorkDir"
Write-Host "Checking seqkit version..."
seqkit version
Write-Host ""


foreach ($seg in $Segments) {

    $Segment   = $seg.Name
    $ChinaFile = $seg.ChinaFile
    $UKFile    = $seg.UKFile
    $MinLen    = $seg.MinLen
    $MaxLen    = $seg.MaxLen

    Write-Host "============================================================"
    Write-Host "Processing segment: $Segment"
    Write-Host "============================================================"

    # Output file names
    $MergedFile      = "China_UK_${Segment}_NT.fasta"
    $LenFilteredFile = "China_UK_${Segment}_NT_lenfiltered.fasta"
    $CleanFile       = "China_UK_${Segment}_NT_lenfiltered_clean.fasta"
    $N10FilteredFile = "China_UK_${Segment}_NT_len_N10_filtered.fasta"

    # -------------------------------------------------------------------------
    # 1. Merge China and UK FASTA files
    # -------------------------------------------------------------------------

    Write-Host "Merging input FASTA files..."
    Write-Host "  China: $ChinaFile"
    Write-Host "  UK:    $UKFile"
    Write-Host "  Out:   $MergedFile"

    Get-Content $ChinaFile, $UKFile | Set-Content $MergedFile

    Write-Host "Merged FASTA stats:"
    seqkit stats $MergedFile
    Write-Host ""


    # -------------------------------------------------------------------------
    # 2. Remove gaps and filter sequences by length
    # -------------------------------------------------------------------------
    # -g removes gaps/spaces before applying the length filter.
    # This is useful if downloaded FASTA files contain gap characters.
    # Length filtering removes partial and abnormal records.

    Write-Host "Removing gaps and filtering by length..."
    Write-Host "  Length range: $MinLen-$MaxLen bp"

    seqkit seq -g -m $MinLen -M $MaxLen $MergedFile -o $LenFilteredFile

    Write-Host "Length-filtering stats:"
    seqkit stats $MergedFile $LenFilteredFile
    Write-Host ""


    # -------------------------------------------------------------------------
    # 3. Replace invalid nucleotide characters with N
    # -------------------------------------------------------------------------
    # Only A, C, G, T and N are retained as valid nucleotide characters.
    # Any other character is converted to N.

    Write-Host "Replacing invalid nucleotide characters with N..."

    seqkit replace `
        -s `
        -p "[^ACGTNacgtn]" `
        -r "N" `
        $LenFilteredFile `
        -o $CleanFile

    Write-Host "Invalid-character cleaning stats:"
    seqkit stats $LenFilteredFile $CleanFile
    Write-Host ""


    # -------------------------------------------------------------------------
    # 4. Remove sequences with >10% N
    # -------------------------------------------------------------------------

    Write-Host "Removing sequences with more than $($MaxNProp * 100)% N..."

    seqkit fx2tab $CleanFile |
        ForEach-Object {
            $cols = $_ -split "`t"
            $name = $cols[0]
            $seq  = $cols[1].ToUpper()

            $nCount = ([regex]::Matches($seq, "N")).Count
            $nProp  = $nCount / $seq.Length

            if ($nProp -le $MaxNProp) {
                "$name`t$seq"
            }
        } |
        seqkit tab2fx -o $N10FilteredFile

    Write-Host "N-filtering stats:"
    seqkit stats $CleanFile $N10FilteredFile
    Write-Host ""


    # -------------------------------------------------------------------------
    # 5. Final summary for this segment
    # -------------------------------------------------------------------------

    Write-Host "Final summary for $Segment:"
    seqkit stats $MergedFile $LenFilteredFile $CleanFile $N10FilteredFile
    Write-Host ""

    Write-Host "Final cleaned FASTA for $Segment:"
    Write-Host "  $N10FilteredFile"
    Write-Host ""
}


Write-Host "============================================================"
Write-Host "All segments processed."
Write-Host "Final files:"
Write-Host "  China_UK_PB1_NT_len_N10_filtered.fasta"
Write-Host "  China_UK_PB2_NT_len_N10_filtered.fasta"
Write-Host "  China_UK_PA_NT_len_N10_filtered.fasta"
Write-Host "============================================================"
