#
# Cookbook:: acme_win_web
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


include_recipe 'powershell::powershell5'

logFolder = 'C:\Logs'
directory 'Log_Folder' do
    action :create
    path logFolder
end
dsc_resource "#{cookbook_name}_Create_Logs_Share" do
	resource :script
	property :setscript, "$args = @('share', '\"Logs\"=\"" + logFolder + "\"', '/GRANT:Everyone,READ');& 'net' $args"
  property :getscript, 'Will create Logs file share with read access for everyone.'
	property :testscript, '(& "net" "share" "Logs" 2>&1)[0] -isnot [System.Management.Automation.ErrorRecord]'
end

dsc_resource 'Data_Folder' do
    resource :file
    property :destinationpath, 'C:\Data'
    property :type, 'Directory'
end
