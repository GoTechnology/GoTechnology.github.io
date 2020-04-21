# Make sure we're in the right place
c:
cd\
cd GoTechnology\GoTechnology.github.io\src

# header
$header = Get-Content -Path header.txt

# top, will be injected before the version list and shown at the top.
[string]$top = Get-Content -Path top.txt

#bottom, will be injected after the version list and before the known issues
[string]$bottom = Get-Content -Path bottom.txt

c:
cd\
cd .\gotechnology\gotechnology.github.io\v

$versionOutputArrayList = [System.Collections.ArrayList]@()
$versionInputArray = Get-ChildItem -Directory | Sort-Object name -Descending
foreach ($version in $versionInputArray)
{
    $Row = "" | Select Version, Docx, PDF
    cd $version #go to the version directory so we can see if it's empty or not


    # it will be empty if it's a maintenance release, so we remove the links and add asterisks
    if(((Get-ChildItem | Measure-Object).Count -eq 0) -Or (((Get-ChildItem | Measur-Object).Count -eq 1) -And (Test-Path -Path '.gitignore')))
    {
        $Row.Version = $ExecutionContext.InvokeCommand.ExpandString('$version')
        $Row.Docx = $ExecutionContext.InvokeCommand.ExpandString('*')
        $Row.PDF = $ExecutionContext.InvokeCommand.ExpandString('*')
    }
    # otherwise we add the links to the documents
    else
    {
        $Row.Version = $ExecutionContext.InvokeCommand.ExpandString('<a href=v/$version/$version.htm>$version</a>')
        $Row.Docx = $ExecutionContext.InvokeCommand.ExpandString('<a href=v/$version/$version.docx>.docx</a>')
        $Row.PDF = $ExecutionContext.InvokeCommand.ExpandString('<a href=v/$version/$version.pdf>.pdf</a>')
    }
    $versionOutputArrayList.Add($Row)
    cd ..
}
#convert the version list to HTML - when we do this it will change the < and > to &lt; etc, so we need to rewrite those
$htmlOutput = $versionOutputArrayList | ConvertTo-Html -head $header -PreContent $top -PostContent $bottom | foreach {$_.replace("&lt;","<").replace("&gt;",">")}

#navigate to the folder where the known issues are stored
c:
cd\
cd GoTechnology\GoTechnology.github.io\src
#add in the known issues table
$htmlOutput += import-csv Filter.csv | ConvertTo-Html -Fragment 

#add in the closing tags
$htmlOutput += "</body></html>" 

#fix the table styling and then write the file to index.html
$htmlOutput | foreach {$_.replace('<table>','<table class="table table-sm table-bordered table-striped"')} | Out-File -Encoding utf8 ..\index.html