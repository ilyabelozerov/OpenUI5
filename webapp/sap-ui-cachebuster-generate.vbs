Set objFSO = CreateObject("Scripting.FileSystemObject")

iFileCounter = 0

outFile="sap-ui-cachebuster-info.json"
Set objTxtFile = objFSO.CreateTextFile(outFile,True)
objTxtFile.Write "{"  & vbCrLf		
		
sCurrentFolder = objFSO.GetAbsolutePathName(".")
Set objSuperFolder = objFSO.GetFolder(sCurrentFolder)
Call ShowSubfolders (objSuperFolder)

objTxtFile.Write vbCrLf & "}"  	
objTxtFile.Close
Wscript.Echo "Files written: " & iFileCounter

WScript.Quit 0

Sub ShowSubFolders(fFolder)
    Set objFolder = objFSO.GetFolder(fFolder.Path)
    Set colFiles = objFolder.Files
    For Each objFile in colFiles
        If Left(objFile.name, 19) <> "sap-ui-cachebuster-" Then
			If  iFileCounter > 0 Then 
				objTxtFile.Write "," & vbCrLf		
			End If
			sRelPath = Mid(objFile.Path, Len(sCurrentFolder) + 2)
			sRelPath = Replace(sRelPath,"\","/")
			
			objTxtFile.Write """" & sRelPath & """ : """ & TimeStamp(objFile.DateLastModified) & """"
			iFileCounter = iFileCounter + 1
        End If
    Next

    For Each Subfolder in fFolder.SubFolders
        ShowSubFolders(Subfolder)
    Next
End Sub

Function TimeStamp(t)
    TimeStamp = Year(t) & _
    Right("0" & Month(t),2) & _
    Right("0" & Day(t),2) & _  
    Right("0" & Hour(t),2) & _
    Right("0" & Minute(t),2) & _ 
    Right("0" & Second(t),2) 
End Function