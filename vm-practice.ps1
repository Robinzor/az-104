# source https://docs.microsoft.com/en-us/learn/modules/automate-azure-tasks-with-powershell/6-exercise-create-resource-interactively

# create
$vm = (Get-AzVM -Name "testvm-weu-01" -ResourceGroupName learn-27ef264a-63e6-4b1c-bf18-7474be71e117)
$vm

# show vm info
$vm.HardwareProfile
$vm.StorageProfile.OsDisk
$vm | Get-AzVMSize

# connect ssh
$ip = (Get-AzPublicIpAddress -ResourceGroupName "learn-27ef264a-63e6-4b1c-bf18-7474be71e117" -Name "testvm-weu-01")
$ip = $ip | Select-Object IpAddress -ExpandProperty IpAddress
ssh robin@$ip

# delete
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName

# List all resources in resource group
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table

# delete network interface
$vm | Remove-AzNetworkInterface –Force

# delete OS disk
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force

# delete virtual network
Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force

# delete NSG
Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force

# delete network interface
$vm | Remove-AzNetworkInterface –Force

# Delete all resource in resource group
Remove-AzResourceGroup "learn-27ef264a-63e6-4b1c-bf18-7474be71e117" -Force -Verbose

