require 'chef/knife/proxmox_base'


class Chef
  class Knife
    class ProxmoxPoolList < Knife

      include Knife::ProxmoxBase

      banner "knife proxmox pool list (options)"

      def run
        connection

        pool_list = [
          ui.color('#', :bold),
          ui.color('Pool ID', :bold),
          ui.color('Comment', :bold),
        ]

        @connection["cluster/resources?type=pool"].get @auth_params do |response, request, result, &block|
          pool_index = 1

          JSON.parse(response.body)['data'].each { |entry|
            pool_list << pool_index.to_s
            pool_list << entry['poolid']
            pool_list << entry['comment']
            pool_index+=1
          }
        end
        puts ui.list(pool_list, :uneven_columns_across, 6)
      end
    end
  end
end
