# Get the date and time
$updatedOn = Get-Date
# header + footer info
$header = "<title>hub2 Documents</title>
<link rel=`"stylesheet`" href=`"site.css`"/>
<link href=`"https://fonts.googleapis.com/css?family=PT+Sans`" rel=`"stylesheet`">
<link rel=`"shortcut icon`" href=`"favicon.ico`">"

# title, will be injected before the filter file and shown at the top.
$title = "<h1><img src=`"qedilogodevice_white.png`"> hub2 Documents</h1>
<div>
    <span class=`"red-text left`"><span class=`"bold`">WARNING:</span> This is a living document and subject to continual change.</span>
    <span class=`"right italic`">Last updated " + $updatedOn.ToLongDateString() + " " + $updatedOn.ToLongTimeString() + "</span>
    <br/>
</div>
<br />
<hr />
<div class=`"center`">
			<h2>
				<a href=`"r/`">Roadmap</a>
			</h2>
		<hr />
		</div>
		<div id=`"Version`" class=`"center`">
		    <h2>Version Notes</h2>
			<table>
				<tr>
					<th>Version</th>
					<th>.docx</th>
					<th>.pdf</th>
				</tr>
				<tr>
					<td><a href=`"v/1_1.htm`">1.1</a></td>
					<td><a href=`"v/1_1.docx`">.docx</a></td>
					<td><a href=`"v/1_1.pdf`">.pdf</a></td>
				</tr>
				<tr>
					<td><a href=`"v/1_2.htm`">1.2</a></td>
					<td><a href=`"v/1_2.docx`">.docx</a></td>
					<td><a href=`"v/1_2.pdf`">.pdf</a></td>
				</tr>
			</table>
		<hr />
		</div>
        <div id=`"API`" class=`"center`">
        	<h2>
				<a href=`"api/`">hub2 API Introductory Wiki</a>
			</h2>
        </div>
        <hr />
		<div id=`"Issue`" class=`"center`">
<h2>Known Issues</h2>" 

# Make sure we're in the right place
c:
cd\
cd GoTechnology\qedi-GoTechnology.github.io\src

# import the CSV and pipe through to the Convert command, add the header then (before the contents of Filter.csv) 
# add the title. After the contents of Filter.csv add the key tables and output using utf8 encoding (so the css 
# works correctly
import-csv Filter.csv | ConvertTo-Html -head $header -PreContent $title | Out-File -Encoding utf8 ..\index.html
