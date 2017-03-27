describe 'when_running_the_default_recipe' {

  it 'should create Data folder' {
      Test-Path 'C:\Data' | should be $true
  }
  it 'should create Log folder' {
      Test-Path 'C:\Logs' | should be $true
  }
  
  if ([System.Environment]::OSVersion.Version.Major -lt 10) {
    it 'should create Logs file share' {
        $folderName = 'Logs'
        (& 'net' 'share' $folderName) | should not be $null

        it 'should give all users read access to Logs file share' {
            (& 'net' 'share' $folderName)[6].Contains('Everyone, READ') | should be $true
        }
    }
  } else {
    it 'should create Logs file share' {
        (get-smbshare 'Logs') | should not be $null

    }
        it 'should give all users read access to Logs file share' {
            $LogsShareAccess = Get-SmbShareAccess -Name 'Logs'
            $GuestShare = $LogsShareAccess | Where-Object { $_.AccountName.EndsWith('Guest') } | Select-Object -First 1
            $GuestShare.AccessRight | should be 'Read'
        }
    }
}