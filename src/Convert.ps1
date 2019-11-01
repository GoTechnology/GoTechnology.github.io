# Make sure we're in the right place
c:
cd\
cd GoTechnology\GoTechnology.github.io\src

# Get the date and time
$updatedOn = Get-Date
# header + footer info
$header = Get-Content -Path header.txt

# top, will be injected before the filter file and shown at the top.
[string]$top = Get-Content -Path top.txt

# import the CSV and pipe through to the Convert command, add the header then (before the contents of Filter.csv) 
# add the title. After the contents of Filter.csv add the key tables and output using utf8 encoding (so the css 
# works correctly
import-csv Filter.csv | ConvertTo-Html -head $header -PreContent $top | Out-File -Encoding utf8 ..\index.html
