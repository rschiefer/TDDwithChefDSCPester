#
# Author:: Mukta Aphale (<mukta.aphale@clogeny.com>)
# Cookbook:: powershell
# Recipe:: dsc
#
# Copyright:: 2014-2016, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if platform_family?('windows')

  include_recipe 'powershell::powershell4'

  winrm_cmd = if node['powershell']['winrm']['enable_https_transport']
                'powershell.exe winrm get winrm/config/listener?Address=*+Transport=HTTPS'
              else
                'powershell.exe winrm get winrm/config/listener?Address=*+Transport=HTTP'
              end

  shell_out = Mixlib::ShellOut.new(winrm_cmd)
  shell_out.run_command

  include_recipe 'powershell::winrm' if shell_out.exitstatus == 1
else
  Chef::Log.warn('DSC can only be run on the Windows platform.')
end
