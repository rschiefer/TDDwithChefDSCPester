describe "when_running_the_default_recipe" {

  it "should create Data folder" {
      Test-Path 'C:\Data' | should be $true
  }
  it "should create Log folder" {
      Test-Path 'C:\Logs' | should be $true
  }
}