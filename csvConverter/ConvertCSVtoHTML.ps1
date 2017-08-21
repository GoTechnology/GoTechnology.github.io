$head = "<title>hub2 Roadmap</title>
<link rel=`"stylesheet`" href=`"site.css`"/>
<link href=`"https://fonts.googleapis.com/css?family=PT+Sans`" rel=`"stylesheet`">"
$title = "<h1>hub2 Roadmap</h1>"
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
	<div class=`"table-key`">&nbsp;</div>
	<table class=`"table-key table-striped`">
		<thead>
			<tr class=`"head`">
				<th>Cat.</th>
				<th>Description</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>A</td>
				<td>Extremely likely.</td>
			</tr>
			<tr>
				<td>B</td>
				<td>Very likely.</td>
			</tr>
			<tr>
				<td>C</td>
				<td>Quite likely.</td>
			</tr>
			<tr>
				<td>D</td>
				<td>Possible.</td>
			</tr>
			<tr>
				<td>E</td>
				<td>Quite unlikely.</td>
			</tr>
			<tr>
				<td>F</td>
				<td>Very unlikely.</td>
			</tr>
			<tr>
				<td>G</td>
				<td>Extremely unlikely.</td>
			</tr>
		</tbody>
	</table>"
import-csv Filter.csv | ConvertTo-Html -head $head -PreContent $title -PostContent $key| Out-File -Encoding utf8 ..\index-test.htm
(Get-Content ..\index-test.htm).Replace('<td>Green</td>','<td class = "green">Green</td>') | Set-Content ..\index-test.htm
(Get-Content ..\index-test.htm).Replace('<td>Yellow</td>','<td class = "yellow">Yellow</td>') | Set-Content ..\index-test.htm
(Get-Content ..\index-test.htm).Replace('<td>Red</td>','<td class = "red">Red</td>') | Set-Content ..\index-test.htm