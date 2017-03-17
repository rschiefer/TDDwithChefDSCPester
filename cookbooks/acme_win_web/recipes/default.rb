#
# Cookbook:: acme_win_web
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


include_recipe 'powershell::powershell5'

directory 'Log_Folder' do
    action :create
    path 'C:\Logs'
end
dsc_resource 'Data_Folder' do
    resource :file
    property :destinationpath, 'C:\Data'
    property :type, 'Directory'
end