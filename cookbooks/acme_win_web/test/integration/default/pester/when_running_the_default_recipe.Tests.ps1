describe 'when_running_the_default_recipe' {

  it 'should create Data folder' {
      Test-Path 'C:\Data' | should be $true
  }
  it 'should create Log folder' {
      Test-Path 'C:\Logs' | should be $true
  }
  
  
  it 'should create Logs file share' {
    $folderName = 'Logs'
    (& 'net' 'share' $folderName) | should not be $null

    it 'should give all users read access to Logs file share' {
        (& 'net' 'share' $folderName)[6].Contains('Everyone, READ') | should be $true
    }
  }
}