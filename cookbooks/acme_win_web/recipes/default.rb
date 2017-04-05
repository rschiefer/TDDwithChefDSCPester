#
# Cookbook:: acme_win_web
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# TODO: Add attributes

Chef::Log.debug("nt_version=" + ::Windows::VersionHelper.nt_version(node).to_s)
notWin10 = (::Windows::VersionHelper.nt_version(node) >= 6.1 and ::Windows::VersionHelper.nt_version(node) < 10)

include_recipe 'powershell::powershell5' if notWin10


logFolder = 'C:\Logs'
directory 'Log_Folder' do
    action :create
    path logFolder
end

if notWin10
    dsc_resource "#{cookbook_name}_Create_Logs_Share" do
        resource :script
        property :setscript, "$args = @('share', '\"Logs\"=\"" + logFolder + "\"', '/GRANT:Everyone,READ');& 'net' $args"
        property :getscript, 'Will create Logs file share with read access for everyone.'
        property :testscript, '(& "net" "share" "Logs" 2>&1)[0] -isnot [System.Management.Automation.ErrorRecord]'
    end
else
    dsc_resource "#{cookbook_name}_SmbShare_Resource" do
        resource :script
        property :setscript, 'install-module xSmbShare'
        property :getscript, 'Will download a DSC resource.'
        property :testscript, 'try {(get-dscresource xSmbShare -erroraction stop) -ne $null } catch { return $false}'
    end
    dsc_resource "#{cookbook_name}_Create_Logs_Share" do
        resource :xSmbShare
        property :name, 'Logs'
        property :path, logFolder
        property :readaccess, ['Guest']
        property :ensure, 'Present'
    end
end


dsc_resource 'Data_Folder' do
    resource :file
    property :destinationpath, 'C:\Data'
    property :type, 'Directory'
end



siteName = 'testingDSC_fromChef1'
siteDirectory = "C:\\temp\\#{siteName}"


dsc_resource 'websiteDirectory' do
    resource :file
    property :destinationpath, siteDirectory
    property :type, 'Directory'
end

bindings = WebsiteBindings.new([
        { protocol: 'HTTP', ip: '127.0.0.1', port: 8080 },
        { protocol: 'HTTP', ip: '127.0.0.1', port: 8081 } ])
        .get_self()
dsc_resource 'createWebsite' do
    resource :xWebsite
    property :name, siteName
    property :physicalPath, siteDirectory
    property :BindingInfo, bindings
end
