# 
#
#       A script to concatenate all the files in a directory
#
#
#
$In  = ".";
$Out = "./log.txt";


$files = Get-ChildItem $In;
$stringbuilder = New-Object -TypeName "System.Text.StringBuilder";

for($i = 0; $i -lt $files.Count; $i++) {
    $temp = Get-Content $files[$i].FullName;
    [void]$stringbuilder.Append($temp);
}


Add-Content $Out $stringbuilder.ToString();