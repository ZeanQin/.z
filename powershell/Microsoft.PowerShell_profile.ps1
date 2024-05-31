#### user interface ####
# oh-my-posh --init --shell pwsh --config 'C:\Users\ZeanQin\OhMyPoshThemes\dlg.omp.json' | Invoke-Expression

#### common aliases ####
Set-Alias g git
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias v nvim
Set-Alias ll ls
Set-Alias grep findstr

### kubectl commands ###
Set-Alias k kubectl

#### auto complete && suggestions #####
## fuck
$env:PYTHONIOENCODING="utf-8"
iex "$(thefuck --alias)"

Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin 
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

###### searching #######
Import-Module PSFzf
Set-PsFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'
