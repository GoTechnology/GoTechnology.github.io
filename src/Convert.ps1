# Get the date and time
$updatedOn = Get-Date
# header + footer info
$header = "<title>hub2 Known Issues</title>
<link rel=`"stylesheet`" href=`"..\site.css`"/>
<link href=`"https://fonts.googleapis.com/css?family=PT+Sans`" rel=`"stylesheet`">
<link rel=`"shortcut icon`" href=`"..\favicon.ico`">"

# title, will be injected before the filter file and shown at the top.
$title = "<h1><img src=`"..\qedilogodevice_white.png`"> hub2 Known Issues</h1>
<div>
    <span class=`"red-text left`"><span class=`"bold`">WARNING:</span> This is a living document and subject to continual change.</span>
    <span class=`"right italic`">Last updated " + $updatedOn.ToLongDateString() + " " + $updatedOn.ToLongTimeString() + "</span>
    <br/>
</div>"
# the html for the key tables, will be injected after the filter file and shown at the right
$key = "<table class=`"table-key table-striped`">
		<thead>
			<tr class=`"head`">
				<th>Status</th>
				<th>Description</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class=`"green`">Green</td>
				<td>No blockers.</td>
			<tr>
			<tr>
				<td class=`"yellow`">Yellow</td>
				<td style=`"background-color:#4d4d4e`">Internal or limited blockers.</td>
			<tr>
			<tr>
				<td class=`"red`">Red</td>
				<td>External or severe blockers.</td>
			<tr>
		</tbody>
	</table>"

# Make sure we're in the right place
c:
cd\
cd GoTechnology\qedi-GoTechnology.github.io\src

# import the CSV and pipe through to the Convert command, add the header then (before the contents of Filter.csv) 
# add the title. After the contents of Filter.csv add the key tables and output using utf8 encoding (so the css 
# works correctly
import-csv Filter.csv | ConvertTo-Html -head $header -PreContent $title -PostContent $key | Out-File -Encoding utf8 ..\i\index.html

# Style the Condition fields by performing three find and replace operations.
(Get-Content ..\i\index.html).Replace('<table>','<table class = "table-work table-striped">') | Set-Content ..\i\index.html
(Get-Content ..\i\index.html).Replace('<td>Green</td>','<td class = "green">Green</td>') | Set-Content ..\i\index.html
(Get-Content ..\i\index.html).Replace('<td>Yellow</td>','<td class = "yellow">Yellow</td>') | Set-Content ..\i\index.html
(Get-Content ..\i\index.html).Replace('<td>Red</td>','<td class = "red">Red</td>') | Set-Content ..\i\index.html
