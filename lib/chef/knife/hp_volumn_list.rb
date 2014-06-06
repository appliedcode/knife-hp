#
# Author:: Mohit SEthi <mohit@sethis.in>
# Copyright:: Copyright (c) 2014 Mohit Sethi
# License:: Apache License, Version 2.0
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

require 'fog'

class Chef
  class Knife
    class HpVolumnList < Knife

      include Knife::HpBase

      banner "knife hp volumn list (options)"

      def run
        #connection.volumns.sort_by do |vol|
        #  [vol.name.downcase, vol.id].compact
        #end.each do |vol|
        vol_list = [
          ui.color('ID', :bold),
          ui.color('Name', :bold),
          ui.color('Description', :bold),
          ui.color('Size(GB)', :bold),
        ]

        #puts "Volumns:"
        #puts connection('block_storage').volumes.inspect
        connection('block_storage').volumes.sort_by do |vol|
          [vol.name.downcase, vol.id, vol.size].compact
        end.each do |vol|
            vol_list << vol.id
            vol_list << vol.name
            vol_list << vol.description
            vol_list << vol.size
          end

        vol_list = vol_list.map do |item|
          item.to_s
        end

        puts ui.list(vol_list, :uneven_columns_across, 4)

      end

    end
  end
end
