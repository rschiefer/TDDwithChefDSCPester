#
# Cookbook:: acme_win_web
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

# TODO: Add Platform specific tests


['2008r2', '10'].each do |version|

  describe 'acme_win_web::default' do
    context "on windows #{version}" do
      before do
        allow_any_instance_of(Chef::Resource::DscResource).to receive(:get_website_bindings).and_return('bindings')
      end
      let(:chef_run) do
      # cached(:chef_run) do
        runner = ChefSpec::SoloRunner.new(platform: 'windows', version: version)
        runner.converge(described_recipe)
      end
      cookbook_name = 'acme_win_web'


      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'creates Logs directory' do
        expect(chef_run).to create_directory('Log_Folder').with(
          path: 'C:\Logs'
        )
      end

      logFolder = 'C:\Logs'
      it 'creates Logs share' do        
        if version == '10'
          expect(chef_run).to run_dsc_resource("#{cookbook_name}_Create_Logs_Share").with(
            resource: :xSmbShare,
            properties: {
              name: 'Logs',
              path: logFolder,
              readaccess: ['Guest'],
              ensure: 'Present'
            }
          )
        else
          expect(chef_run).to run_dsc_resource("#{cookbook_name}_Create_Logs_Share").with(
            resource: :script,
            properties: {
              setscript: "$args = @('share', '\"Logs\"=\"" + logFolder + "\"', '/GRANT:Everyone,READ');& 'net' $args",
              getscript: 'Will create Logs file share with read access for everyone.',
              testscript: '(& "net" "share" "Logs" 2>&1)[0] -isnot [System.Management.Automation.ErrorRecord]'
            }
          )
        end
      end

      it 'creates Data directory' do
        expect(chef_run).to run_dsc_resource('Data_Folder').with(
          resource: :file,
          properties: {
            destinationpath: 'C:\Data',
            type: 'Directory'
          } 
        )
      end
      
      it 'creates website directory' do
        expect(chef_run).to run_dsc_resource('websiteDirectory').with(
          resource: :file,
          properties: {
            destinationpath: 'C:\temp\testingDSC_fromChef1',
            type: 'Directory'
          }
        )
      end

      
      # it 'creates website in IIS' do
      #   expect(chef_run).to run_dsc_resource('createWebsite').with(
      #     resource: :xWebsite,
      #     properties: {
      #       name: 'testingDSC_fromChef1',
      #       physicalPath: 'C:\temp\testingDSC_fromChef1',
      #       BindingInfo: 'bindings'
      #     }
      #   )
      # end
    end
  end
end
