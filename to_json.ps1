param($p1)

$data = (Get-Content $p1 -Raw) -split "`r`n"
$uniqueValues = $data | Sort-Object | Get-Unique
$ttp = @()
 
foreach ($value in $uniqueValues) {
    # Count the occurrences of each unique value
    $count = $data | Where-Object { $_ -eq $value } | Measure-Object | Select-Object -First 1 -ExpandProperty Count
    $ttp += @{ Name = $value; Score = $count}
}
 
foreach ($index in (1..($ttp.Count -1))) {
    #find subtech
    if ($ttp[$index].Name -like "*.*") {
        #declaration tech ID T1110.001
        $pos = $ttp[$index].Name.IndexOf(".")
        $leftPart = $ttp[$index].Name.Substring(0, $pos)
        if ($ttp[$index-1].Name -eq $leftPart) {
            #Write-Output "This is parent " $ttp[$index-1].Name
            #save parent element via temp var
            $temp = $ttp[$index-1]
            $counter = 0
            for($i=$index-1; $i -lt $ttp.Length; $i++) {
                #find all parent entries in whole array
                if ($ttp[$i].Name.Contains($temp.Name)) {
                        $counter += $ttp[$i].Score
                        #Write-Output "counter" $counter
                    }
            }
            #parent tech scoring
            $ttp[$index-1].Score = $counter
            $counter = 0
        } else {
            if ($ttp[$index-1].Name -like "*.*") {
                $posPrev = $ttp[$index-1].Name.IndexOf(".")
                $leftPartPrev = $ttp[$index-1].Name.Substring(0, $posPrev)
                if ($leftPart -eq $leftPartPrev) {
                 
                } else {
                    #create parent element
                    $counter = 0
                    for($i=$index; $i -lt $ttp.Length; $i++) {
                        #find all parent entries in whole array
                        if ($ttp[$i].Name.Contains($leftPart)) {
                            $counter += $ttp[$i].Score
                            #Write-Output "counter" $counter
                        }
                    }
                    $ttp += @{ Name = $leftPart; Score = $counter}
                    $counter = 0
                }
            } else {
                $counter = 0
                for($i=$index; $i -lt $ttp.Length; $i++) {
                    #find all parent entries in whole array
                    if ($ttp[$i].Name.Contains($leftPart)) {
                        $counter += $ttp[$i].Score
                        #Write-Output "counter" $counter
                    }
                }
                $ttp += @{ Name = $leftPart; Score = $counter}
                $counter = 0
            }
        }
    } else {
         
    }
}
 
ConvertTo-Json $ttp | Out-File -Encoding UTF8 ".\array_of_objects.json"