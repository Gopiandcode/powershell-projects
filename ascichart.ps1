$Bar_values = @(80, 300, 110, 150, 70, 500)
$Bar_names  = @("Resolved", "New", "Closed", "WIP", "Escalated", "Greater")

$amplifier = 0.1 # mulitplier for vertical scale
$AllResultsMax = $Bar_values | measure -Maximum
$SumBar = ($Bar_values | Measure-Object -Sum).Sum
$HeightPadding = 2
$TotalXAxisLength = 100
$XAxisString = "";
$newline = "`n";


$AverageHeight = [math]::Round(($SumBar/$Bar_values.Count) * $amplifier)
$AverageHeight = $AverageHeight + $HeightPadding

$Actual_values = $Bar_values | ForEach-Object {[math]::Round(($_/$AllResultsMax.Maximum) * $AverageHeight)}
$AllBarHeightsMax = $Actual_values | Measure-Object -Maximum
$Whitespace_Heights = $Actual_values | ForEach-Object {$AllBarHeightsMax.Maximum - $_}


$Whitespace_Heights

$renderString = "";
    for($j = $AverageHeight; $j -ge 0; $j--){

        $renderString = $renderString + "  | ";

        for($i = 0; $i -lt $Bar_names.Count; $i++) {
            Write-Output "J: $j --> i: $i"
            if($Whitespace_Heights[$i] -gt 0) {
                $BarWidthStr = ""
                $BarWidthStr = $BarWidthStr.PadRight($Bar_names[$i].Length+4, " ");
                $renderString = $renderString + $BarWidthStr
                $Whitespace_Heights[$i] = $Whitespace_Heights[$i] - 1
            }



        if($j -eq $Actual_values[$i]) {
            $CountStr = " (" + $Bar_values[$i] + ") "
            $padding = ($Bar_names[$i].Length + 4) - $CountStr.Length

            if($padding -gt 0) {
                $CountStr = $CountStr.PadRight($padding + $CountStr.Length," ");
            }
            $renderString = $renderString + $CountStr;
        }


        if($j -eq ($Actual_values[$i] - 1)) {
            $BarWidthStr = ""
            $BarWidthStr = $BarWidthStr.PadRight($Bar_names[$i].Length + 4, "_");
            $renderString = $renderString + $BarWidthStr;
        }
        if($j -eq ($Actual_values[$i] - 2)) {
             $BarWidthStr = "|"
            $BarWidthStr = $BarWidthStr.PadRight($Bar_names[$i].Length + 3, " ");
            $renderString = $renderString + $BarWidthStr + "|";
        }
        if($j -eq ($Actual_values[$i] - 3)) {
            $renderString = $renderString + "| " + $Bar_names[$i] + " |";
        }
        if($j -lt ($Actual_values[$i] - 3)) {
            $BarWidthStr = "|"
            $BarWidthStr = $BarWidthStr.PadRight($Bar_names[$i].Length + 3, " ");
            $renderString = $renderString + $BarWidthStr + "|"
        }
    }
        $renderString = $renderString + $newline
}
$renderString = $renderString + " " + $XAxisString.PadRight($TotalXAxisLength, "-") + ">" + $newline + $newline

Write-Output $renderString