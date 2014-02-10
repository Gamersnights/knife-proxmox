require 'chef/knife/proxmox_base'


class Chef
  class Knife
    class ProxmoxVmInfo < Knife

      include Knife::ProxmoxBase

      banner "knife proxmox pool info (options)"

      option :pool_id,
        :short => "-I ID",
        :long  => "--pool_id ID",
        :description => "The name identifier of the Pool"

      option :field,
        :short => "-f field",
        :long  => "--field field",
        :description => "Which field to extract from the output"

      def run
        connection

        [:pool_id].each do |param|
          check_config_parameter(param)
        end

        field = config[:field] ||= "all"

        data = pool_info(config[:pool_id], field)

        ui.output(data)

      end
    end
  end
end
