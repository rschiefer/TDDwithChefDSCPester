#
# Author:: Julian C. Dunn (<jdunn@chef.io>)
# Cookbook:: powershell
# Attribute:: powershell3
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
#

if node['platform_family'] == 'windows'
  case node['platform_version'].split('.')[0..1].join('.')
  when '6.1'
    case node['kernel']['machine']
    when 'i386'
      default['powershell']['powershell3']['url'] = 'http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x86.msu'
      default['powershell']['powershell3']['checksum'] = '2a23cb68bc87675c8ec7c7bfdfbb7f99262b69163bc7db7edc76ac1fb436a16e'
    when 'x86_64'
      default['powershell']['powershell3']['url'] = 'http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x64.msu'
      default['powershell']['powershell3']['checksum'] = '8a8e35fa0e613fcc54644b8336d7dabbe5c6b57a1895e9caac2d0065746d1f8d'
    end
  end
end
