function Get-AoC2025Day2Answer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]$InputObject
    )

    [String[]]$ranges = $InputObject -split ','

    [Int64]$answer1 = 0
    [Int64]$answer2 = 0

    foreach ($range in $ranges) {
        [Int64]$start, [Int64]$end = $range -split '-'

        for ($i = $start; $i -le $end; $i++) {
            $string = $i.ToString()

            for ($j = 2; $j -le $string.Length; $j++) {
                [String]$substring = $string.Substring(0, $string.Length / $j)
                if ($string -match "^($substring){2,}$") {
                    Write-Verbose -Message "Match found [$i]"
                    $answer2 += $i
                    break
                }
            }

            if ($string.Length % 2 -ne 0) {
                continue
            }

            $subString1 = $string.Substring(0, $string.Length / 2)
            $substring2 = $string.Substring($string.Length / 2)
            if ($subString1 -eq $substring2) {
                $answer1 += $i
            }
        }
    }

    return [PSCustomObject]@{
        'Part 1' = $answer1
        'Part 2' = $answer2
    }
}

[String]$sampleInput = '11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124'

[String]$challengeInput = '9100-11052,895949-1034027,4408053-4520964,530773-628469,4677-6133,2204535-2244247,55-75,77-96,6855-8537,55102372-55256189,282-399,228723-269241,5874512-6044824,288158-371813,719-924,1-13,496-645,8989806846-8989985017,39376-48796,1581-1964,699387-735189,85832568-85919290,6758902779-6759025318,198-254,1357490-1400527,93895907-94024162,21-34,81399-109054,110780-153182,1452135-1601808,422024-470134,374195-402045,58702-79922,1002-1437,742477-817193,879818128-879948512,407-480,168586-222531,116-152,35-54'