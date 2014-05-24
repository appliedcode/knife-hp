#
# Author:: Matt Ray (<matt@getchef.com>)
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
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

require 'chef/knife/hp_base'

class Chef
  class Knife
    class HpImageList < Knife

      include Knife::HpBase

      banner "knife hp image list (options)"

      option :disable_filter,
      :long => "--disable-filter",
      :description => "Disable filtering of the image list. Currently filters names containing '(deprecated)', '(Ramdisk)' and '(Kernel)'",
      :boolean => true,
      :default => false

      def run

        validate!

        image_list = [
          ui.color('ID', :bold),
          ui.color('Name', :bold),
        ]

        connection.images.sort_by do |image|
          [image.name.downcase, image.id].compact
        end.each do |image|
          unless ((image.name =~ /(deprecated)|(Ramdisk)|(Kernel)/) &&
              !config[:disable_filter])
            image_list << image.id
            image_list << image.name
          end
        end

        image_list = image_list.map do |item|
          item.to_s
        end

        puts ui.list(image_list, :uneven_columns_across, 2)
      end
    end
  end
end
