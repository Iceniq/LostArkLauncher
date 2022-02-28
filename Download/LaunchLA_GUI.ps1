# Load Libraries
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Set Source Directory
if ($MyInvocation.MyCommand.CommandType -eq "ExternalScript")
{ 
    $ScriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition 
}
else
{ 
    $ScriptPath = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0]) 
    if (!$ScriptPath){ $ScriptPath = "." } 
}

# Launch Game Function
function LaunchGame
    {
        cd $ScriptPath
        cd..
        cd..
        cd..

        ./Steam.exe -applaunch 1599340

        [System.Environment]::Exit(0)
    }

# Set RegionID to user choice
function SetServer
    {
        $node = $xml.SelectSingleNode("//UserOption/SaveAccountOptionData")
        $node.RegionID = "$Server"
        $xml.Save($file)
    }

#Set XML file
$file = "$ScriptPath\EFGame\Config\UserOption.xml"

# Load the existing file
$xml = New-Object -TypeName XML
$xml.Load($file)

# Create Form Object
$Form = New-Object system.Windows.Forms.Form
$ConfirmForm = New-Object System.Windows.Forms.Form

# Form Size $ Text
$Form.StartPosition = 'CenterScreen'
$Form.Size = New-Object System.Drawing.Size(350,410)
$Form.Text = "Lost Ark Launcher"
$ConfirmForm.Size = New-Object System.Drawing.Size(200,200)

# Create Label
$Label = New-Object System.Windows.Forms.Label
$Label.Location = New-Object System.Drawing.Size(10,10)
$Label.Size = New-Object System.Drawing.Size(320,30)
$Font = New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Regular)
$Form.Font = $Font
$Label.Text = "Please choose your server"

# Add Label
$Form.Controls.Add($Label)

# Create Button WE
$WEbutton = New-Object System.Windows.Forms.Button
$WEbutton.Location = New-Object System.Drawing.Size(10,60)
$WEbutton.Size = New-Object System.Drawing.Size(310,50)
$WEbutton.Text = "West Europe"
$WEbutton.Add_Click({
                        $Server="WE"
                        SetServer
                        LaunchGame
                    })

# Create Button EE
$EEbutton = New-Object System.Windows.Forms.Button
$EEbutton.Location = New-Object System.Drawing.Size(10,120)
$EEbutton.Size = New-Object System.Drawing.Size(310,50)
$EEbutton.Text = "East Europe"
$EEbutton.Add_Click({
                        $Server="EE"
                        SetServer
                        LaunchGame
                    })

# Create Button WA
$WAbutton = New-Object System.Windows.Forms.Button
$WAbutton.Location = New-Object System.Drawing.Size(10,180)
$WAbutton.Size = New-Object System.Drawing.Size(310,50)
$WAbutton.Text = "West America"
$WAbutton.Add_Click({
                        $Server="WA"
                        SetServer
                        LaunchGame
                    })

# Create Button EA
$EAbutton = New-Object System.Windows.Forms.Button
$EAbutton.Location = New-Object System.Drawing.Size(10,240)
$EAbutton.Size = New-Object System.Drawing.Size(310,50)
$EAbutton.Text = "East America"
$EAbutton.Add_Click({
                        $Server="EA"
                        SetServer
                        LaunchGame
                        
                    })

# Create Button SA
$SAbutton = New-Object System.Windows.Forms.Button
$SAbutton.Location = New-Object System.Drawing.Size(10,300)
$SAbutton.Size = New-Object System.Drawing.Size(310,50)
$SAbutton.Text = "Latin America"
$SAbutton.Add_Click({
                        $Server="SA"
                        SetServer
                        LaunchGame
                    })

# Add Button
$Form.Controls.Add($WEbutton)
$Form.Controls.Add($EEbutton)
$Form.Controls.Add($WAbutton)
$Form.Controls.Add($EAbutton)
$Form.Controls.Add($SAbutton)

# Form Close Mapping
$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter") {$Form.Close()}})
$Form.Add_KeyDown({if ($_.KeyCode -eq "Escape") {$Form.Close()}})

# Set Form Icon
$formIcon = New-Object system.drawing.icon ("$ScriptPath\Binaries\misc\LOSTARK.ico")
$form.Icon = $formicon

# Draw Form
[void]$Form.ShowDialog()