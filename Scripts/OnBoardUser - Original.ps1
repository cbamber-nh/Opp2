[int]$LinesInFile = 0
$Users = New-Object IO.StreamReader 'D:\Dev\Opp-Portal\Scripts\Users.csv'
$Users.ReadLine(); #Skip the header
$myArray = [System.Collections.ArrayList]@()
$myArray = New-Object -TypeName "System.Collections.ArrayList"
$accounts = @{}
 while(($line = $Users.ReadLine()) -ne $null){ 
    $LinesInFile++ 
    $accounts.Add($LinesInFile, $line)
    $myArray += $line
 }

echo "Logging into Azure..."
Az Login

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
az account set --subscription $menuOptions.$SubscriptionChoice
echo "Subscription set "


Write-Host "Number of new users to add: $($LinesInFile)" -ForegroundColor Green


Read-Host -Prompt "Press any key to continue or CTRL+C to quit" 

[string]$DefaultPassword = "dfdfsd34!234"



$myArray.ForEach(
    { 
        $columns = $PSItem.Split(",") 
        [string]$displayName = $columns[0].Trim()
        [string]$username = $columns[1].Trim()
        

        $PasswordProfile = New-Object -TypeName Microsoft.Open.azureAD.Model.PasswordProfile
 
        $PasswordProfile.ForceChangePasswordNextLogin = $True

        $passw = 'ot14pass!'

        $PasswordProfile.Password = $passw

        $Random = Get-Random -Maximum 999999

        $MailNickname = $username

        $UserPrincipalName = $MailNickname + "@ot14.onmicrosoft.com"
        $UserPrincipalName

        #New-AzureADUser -DisplayName $displayName -PasswordProfile $PasswordProfile -PasswordPolicies "DisablePasswordExpiration" -UserPrincipalName $UserPrincipalName -AccountEnabled $true -MailNickName $MailNickname

        az ad user create --display-name $displayName --password $DefaultPassword --user-principal-name $UserPrincipalName --force-change-password-next-login true --mail-nickname $MailNickname

    }
)


#az ad user create --display-name "Aaron Finnegan" --password "dfdfsd34!234" --user-principal-name "aafinnegan@ot14.onmicrosoft.com" --force-change-password-next-login true --mail-nickname "aaron.finnegan"

