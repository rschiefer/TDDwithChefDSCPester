#
# Cookbook:: acme_win_web
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'acme_win_web::default' do
    let(:chef_run) do
    # cached(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'windows', version: '2008r2')
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
    it 'creates Data directory' do
      expect(chef_run).to run_dsc_resource('Data_Folder').with(
        resource: :file,
        properties: {
          destinationpath: 'C:\Data',
          type: 'Directory'
        } 
      )
    end
    
end
