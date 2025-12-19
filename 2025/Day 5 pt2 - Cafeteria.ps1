function Get-AoC2025Day5Answer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]$InputObject
    )

    [String[]]$rows = $InputObject -split ([System.Environment]::NewLine)
    [Int64[]]$availableIngredients = @()
    [Boolean]$test = $false
    [Int64[][]]$ranges = @()
    [Int32]$availableFreshIngredients = 0
    [Int64]$freshIngredientIdCount = 0

    [Int64[]]$availableIngredients = foreach ($row in $rows) {
        if ([String]::IsNullOrWhiteSpace($row)) {
            [Boolean]$test = $true
            continue
        }

        if ($test) {
            [Int64]::Parse($row)
        } else {
            [Int64[]]$parsedRange = $row -split '-'

            foreach ($range in $ranges) {
                if (($parsedRange[0] -lt $range[0]) -and ($parsedRange[1] -ge $range[0])) {
                    $range[0] = $parsedRange[0]

                    if ($parsedRange[1] -ge $range[1]) {
                        $range[1] = $parsedRange[1]
                    }
                } elseif (($parsedRange[0] -le $range[1]) -and ($parsedRange[1] -gt $range[1])) {
                    $range[1] = $parsedRange[0]
                } elseif (($parsedRange[0] -ge $range[0]) -and ($parsedRange[1] -le $range[1])) {
                    # Both the lower and upper bound are contained in a range that already exists
                    break
                } else {
                    $ranges += ,$parsedRange
                }
            }
        }
    }

    foreach ($range in $ranges) {
        $freshIngredientIdCount += ($range[1] - $range[0])
    }

    foreach ($ingredientId in $availableIngredients) {
        foreach ($range in $ranges) {
            if (($ingredientId -ge $range[0]) -and ($ingredientId -le $range[1])) {
                $availableFreshIngredients ++
                break
            }
        }
    }

    return [PSCustomObject]@{
        'Part 1' = $availableFreshIngredients
        'Part 2' = $freshIngredientIdCount
    }
}

