#--------------------------------------------------------------------------------- 
#The sample scripts are not supported under any Microsoft standard support 
#program or service. The sample scripts are provided AS IS without warranty  
#of any kind. Microsoft further disclaims all implied warranties including,  
#without limitation, any implied warranties of merchantability or of fitness for 
#a particular purpose. The entire risk arising out of the use or performance of  
#the sample scripts and documentation remains with you. In no event shall 
#Microsoft, its authors, or anyone else involved in the creation, production, or 
#delivery of the scripts be liable for any damages whatsoever (including, 
#without limitation, damages for loss of business profits, business interruption, 
#loss of business information, or other pecuniary loss) arising out of the use 
#of or inability to use the sample scripts or documentation, even if Microsoft 
#has been advised of the possibility of such damages 
#--------------------------------------------------------------------------------- 

#requires -version 2.0

Function ConvertTo-OSCPDF
{
<#
 	.SYNOPSIS
        ConvertTo-OSCPDF is an advanced function which can be used to covert Word document to PDF file.
    .DESCRIPTION
        ConvertTo-OSCPDF is an advanced function which can be used to covert Word document to PDF file.
    .PARAMETER Path
		Specifies the path of Word document.
	.PARAMETER StartPage
		Specifies the Start page of Word document you want to convert.
    .PARAMETER EndPage
		Specifies the End page of Word document you want to convert.
    .EXAMPLE
        C:\PS> ConvertTo-OSCPDF -Path D:\Word\
		
		File_Name                               Action(Convert to PDF)
		---------                               --------------------
		Microsoft1.docx                         Finished
		Microsoft2.docx                         Finished
		Microsoft3.docx                         Finished
		Microsoft4.docx                         Finished
		
    .EXAMPLE
        C:\PS> ConvertTo-OSCPDF -Path D:\Word\Microsoft1.docx
		
		File Name                               Action(Convert to PDF)
		---------                               --------------------
		Microsoft1.docx                         Finished
		
	.EXAMPLE
        C:\PS> ConvertTo-OSCPDF -Path D:\Word\Microsoft1.docx -StartPage 2 -EndPage 15
		
		File Name                               Action(Convert to PDF)
		---------                               --------------------
		Microsoft1.docx                         Finished
#>
	[CmdletBinding(SupportsShouldProcess=$true,DefaultParameterSetName="Default")]
	Param
	(
		[Parameter(Mandatory=$true,Position=0)]
		[Alias('p')][String]$Path,
		[Parameter(Mandatory=$true,Position=1,ParameterSetName="Customize")]
		[Alias('sp')][Int32]$StartPage,
		[Parameter(Mandatory=$true,Position=2,ParameterSetName="Customize")]
		[Alias('ep')][Int32]$EndPage
	)
	
	If($PSCmdlet.ShouldProcess("Convert Word document to PDF file."))
	{
		If(Test-Path -Path $Path)
		{
			#get all related to wd document files
			$wdDocumentFiles = Get-ChildItem -Path $Path -Recurse -Include *.doc,*.docx
			If ($wdDocumentFiles)
			{
				Add-type -AssemblyName Microsoft.Office.Interop.Word
				$wdApplication = New-Object -ComObject "Word.Application"
       			
				######define the parameters######
				$wdExportFormat = [Microsoft.Office.Interop.Word.WdExportFormat]::wdExportFormatPDF
				$OpenAfterExport = $false
				$wdExportOptimizeFor = [Microsoft.Office.Interop.Word.WdExportOptimizeFor]::wdExportOptimizeForOnScreen
				$wdExportItem = [Microsoft.Office.Interop.Word.WdExportItem]::wdExportDocumentContent
				$IncludeDocProps = $true
				$KeepIRM = $true
				$wdExportCreateBookmarks = [Microsoft.Office.Interop.Word.WdExportCreateBookmarks]::wdExportCreateWordBookmarks
				$DocStructureTags = $true
				$BitmapMissingFonts = $true
				$UseISO19005_1 = $fals
				
				If($StartPage -and $EndPage)
				{
					$wdExportRange = [Microsoft.Office.Interop.Word.WdExportRange]::wdExportFromTo
					$wdStartPage = $StartPage
					$wdEndPage = $EndPage
				}
				Else
				{
					$wdExportRange = [Microsoft.Office.Interop.Word.WdExportRange]::wdExportAllDocument
					$wdStartPage = 0
					$wdEndPage = 0
				}
				
				#Convert wd document to PDF file
				Foreach($wdDocumentFile in $wdDocumentFiles)
				{			
					$wdDocumentCounts = $wdDocumentFiles.Count
					If(!$wdDocumentCounts)
					{
						$wdDocumentCounts = 1
					}
					
					$intNumberwd++
					
					#get the file name
					$wdDocumentName = $wdDocumentFile.Name 
					#get the directory of file
					$wdDocumentPathDirectory = $wdDocumentFile.DirectoryName 
					$wdDocumentBaseName = $wdDocumentFile.BaseName
					$wdDocumentPath = $wdDocumentFile.FullName
					#define an output file path
					$OutputFilePath = "$wdDocumentPathDirectory\$wdDocumentBaseName.pdf"
					
					Try
					{
						#Displays a progress bar within a Windows PowerShell command window.
						Write-Progress -Activity "Converting Word document [$wdDocumentName] to PDF file" `
						-Status "$intNumberwd of $wdDocumentCounts Word document(s)" -PercentComplete $($intNumberwd/$wdDocumentCounts*100)
						
						#Open the Word document
						$wdDocument = $wdApplication.Documents.Open($wdDocumentPath)
						#Sets the format paramters
						$wdDocument.ExportAsFixedFormat($OutputFilePath,$wdExportFormat,$OpenAfterExport,`
						$wdExportOptimizeFor,$wdExportRange,$wdStartPage,$wdEndPage,$wdExportItem,$IncludeDocProps,`
						$KeepIRM,$wdExportCreateBookmarks,$DocStructureTags,$BitmapMissingFonts,$UseISO19005_1)
						
						#release the object
						$wdDocument.Close()
						[void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($wdDocument)
						
						$Properties = @{'File Name' = $wdDocumentName
										'Action(Convert to PDF)' = If(Test-Path -Path $OutputFilePath)
																	{"Finished"}
																	Else
																	{"Unfinished"}
										}
										
						$objWord = New-Object -TypeName PSObject -Property $Properties
						$objWord
					}
					Catch
					{
						Write-Warning "A few Word documents have been lost in this converting. $wdDocumentName cannot convert to PDF file."
					}
				}
				
				######release the object######
				$wdApplication.Quit() 
				[void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($wdApplication)
				[GC]::Collect()
				[GC]::WaitForPendingFinalizers()
			}
			Else
			{
				Write-Warning "Please make sure that at least one Word document file in the ""$Path""."
			}
		}
		Else
		{
			Write-Warning "The path does not exist, plese input the correct path."
		}
	}
}
