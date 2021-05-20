## Read the file contents
[int]$LinesInFile = 0
$Users = New-Object IO.StreamReader 'D:\Dev\Opp-Portal\Scripts\Users.csv'
$Users.ReadLine(); #Skip the header
$myArray = [System.Collections.ArrayList]@()
$myArray = New-Object -TypeName "System.Collections.ArrayList"
$accounts = @{}
 while(($line = $Users.ReadLine()) -ne $null){ 
    $LinesInFile++ 
    $myArray += $line
 }

## Login to Azure from Web
echo "Logging into Azure..."
Az Login --output none

## Allow the user to choose between subscription i.e. where the users will be created
$Subs = az account list --query "[].{Name:name}" --output table

$menuOptions = [ordered]@{}

[int]$menuOptionCounter = 1;
for($i=2;$i -lt $Subs.Length; $i++){
    #echo $Subs[$i]
    $menuOptions.Add($menuOptionCounter, $Subs[$i])
    $menuOptionCounter++
}

echo "Available Subscriptions"
foreach($row in $menuOptions){
    echo $row
}

[int]$SubscriptionChoice = Read-Host "Choose Subscription Option"

if($SubscriptionChoice -lt 0 -or $SubscriptionChoice -gt $menuOptions.Count) {
    Write-Host "Invalid option selected. Terminating..." -ForegroundColor Red
    exit
}

az account set --subscription $menuOptions.$SubscriptionChoice
Write-Host "Subscription set $($menuOptions.$SubscriptionChoice)" -ForegroundColor Green


Write-Host "Number of new users to add: $($LinesInFile)" -ForegroundColor Green

## Ask for confirmation to proceed
Read-Host -Prompt "Press any key to continue or CTRL+C to quit" 

[string]$DefaultPassword = "dfdfsd34!234"


## Loop through each person and insert them to Azure
$myArray.ForEach(
    { 
        $columns = $PSItem.Split(",") 
        [string]$displayName = $columns[0].Trim()
        [string]$username = $columns[1].Trim()

        $MailNickname = $username

        $UserPrincipalName = $MailNickname + "@ot14.onmicrosoft.com"

        az ad user create --display-name $displayName --password $DefaultPassword --user-principal-name $UserPrincipalName --force-change-password-next-login true --mail-nickname $MailNickname

    }
)

