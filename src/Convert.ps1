# Get the date and time
$updatedOn = Get-Date
# header + footer info
$header_Roadmap = "<title>hub2 Roadmap</title>
<link rel=`"stylesheet`" href=`"site.css`"/>
<link href=`"https://fonts.googleapis.com/css?family=PT+Sans`" rel=`"stylesheet`">
<link rel=`"shortcut icon`" href=`"favicon.ico`">"
$header_Issues = "<title>hub2 Known Issues</title>
<link rel=`"stylesheet`" href=`"site.css`"/>
<link href=`"https://fonts.googleapis.com/css?family=PT+Sans`" rel=`"stylesheet`">
<link rel=`"shortcut icon`" href=`"favicon.ico`">"

# title, will be injected before the filter file and shown at the top.
$title_Roadmap = "<h1><img src=`"qedilogodevice_white.png`"> hub2 Roadmap</h1>
<div>
    <span class=`"red-text left`"><span class=`"bold`">WARNING:</span> This is a living document and subject to continual change. <a href=`"issues.html`">Known Issues List</a></span>
    <span class=`"right italic`">Last updated " + $updatedOn.ToLongDateString() + " " + $updatedOn.ToLongTimeString() + "</span>
    <br/>
</div>"
$title_Issues = "<h1><img src=`"qedilogodevice_white.png`"> hub2 Known Issues</h1>
<div>
    <span class=`"red-text left`"><span class=`"bold`">WARNING:</span> This is a living document and subject to continual change. <a href=`"index.html`">Feature Roadmap</a></span>
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
	</table>
	<div class=`"table-key`"><hr/></div>
	<table class=`"table-key table-striped`">
		<thead>
			<tr class=`"head`">
				<th>Class</th>
				<th>Description</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>A</td>
				<td>Extremely high.</td>
			</tr>
			<tr>
				<td>B</td>
				<td>Very high.</td>
			</tr>
			<tr>
				<td>C</td>
				<td>Quite high.</td>
			</tr>
			<tr>
				<td>D</td>
				<td>Moderate</td>
			</tr>
			<tr>
				<td>E</td>
				<td>Quite low.</td>
			</tr>
			<tr>
				<td>F</td>
				<td>Very low.</td>
			</tr>
			<tr>
				<td>G</td>
				<td>Extremely low.</td>
			</tr>
		</tbody>
	</table>
<div class=`"table-key`">Request Index Class represents an amalgamated ranking of possible modifications based on business and client drivers.<hr/></div>
	"

# Make sure we're in the right place
cd\
cd GoTechnology\qedi-GoTechnology.github.io\src

# import the CSV and pipe through to the Convert command, add the header then (before the contents of Filter.csv) 
# add the title. After the contents of Filter.csv add the key tables and output using utf8 encoding (so the css 
# works correctly
import-csv Filter.csv | ConvertTo-Html -head $header_Roadmap -PreContent $title_Roadmap -PostContent $key | Out-File -Encoding utf8 ..\index.html

# Style the Condition fields by performing three find and replace operations.
(Get-Content ..\index.html).Replace('<table>','<table class = "table-work table-striped">') | Set-Content ..\index.html
(Get-Content ..\index.html).Replace('<td>Green</td>','<td class = "green">Green</td>') | Set-Content ..\index.html
(Get-Content ..\index.html).Replace('<td>Yellow</td>','<td class = "yellow">Yellow</td>') | Set-Content ..\index.html
(Get-Content ..\index.html).Replace('<td>Red</td>','<td class = "red">Red</td>') | Set-Content ..\index.html

import-csv Issues.csv | ConvertTo-Html -head $header_Issues -PreContent $title_Issues -PostContent $key | Out-File -Encoding utf8 ..\issues.html
# Style the Condition fields by performing three find and replace operations.
(Get-Content ..\issues.html).Replace('<table>','<table class = "table-work table-striped">') | Set-Content ..\issues.html
(Get-Content ..\issues.html).Replace('<td>Green</td>','<td class = "green">Green</td>') | Set-Content ..\issues.html
(Get-Content ..\issues.html).Replace('<td>Yellow</td>','<td class = "yellow">Yellow</td>') | Set-Content ..\issues.html
(Get-Content ..\issues.html).Replace('<td>Red</td>','<td class = "red">Red</td>') | Set-Content ..\issues.html