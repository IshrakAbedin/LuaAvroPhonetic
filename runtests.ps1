$time = Measure-Command { $output = lua ./test/test.lua }

# Format the time as hh:mm:ss.fff
$formattedTime = "{0:D2}:{1:D2}:{2:D2}.{3:D3}" -f $time.Hours, $time.Minutes, $time.Seconds, $time.Milliseconds

# Output the formatted time
Write-Output $output
Write-Output "Execution time: $formattedTime"
exit $LASTEXITCODE
