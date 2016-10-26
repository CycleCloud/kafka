module NoPackage
  class Helpers


    def self.search_for_packages(resources, opts={})
      Chef::Log.info('Searching for chef package resources...')

      packages = resources.select { |key, value|
        Chef::Log.info("Resource: #{key.to_s}")
        key.to_s.match(/^[[:alpha:]]*_?package/) 
      }
      Chef::Log.info("Found the following chef package resources : #{packages.inspect}")

      packages
    end

    def self.disable_packages(resources, opts={})
      Chef::Log.info('Disabling ALL chef package resources...')

      resources.each do |r|
        if r.resource_name.to_s.match(/^[[:alpha:]]*_?package/)
          Chef::Log.info("Disabling Resource : #{r.resource_name}")
          r.instance_exec do
            action :nothing
          end
        end
      end
    end


    def self.disable_user(resources, opts={})
      Chef::Log.info('Disabling ALL chef user resources...')

      resources.each do |r|
        if r.resource_name.to_s.match(/^[[:alpha:]]*_?user/)
          Chef::Log.info("Disabling Resource : #{r.resource_name}")
          r.instance_exec do
            action :nothing
          end
        end
      end
    end


    def self.disable_group(resources, opts={})
      Chef::Log.info('Disabling ALL chef group resources...')

      resources.each do |r|
        if r.resource_name.to_s.match(/^[[:alpha:]]*_?group/)
          Chef::Log.info("Disabling Resource : #{r.resource_name}")
          r.instance_exec do
            action :nothing
          end
        end
      end
    end
    
  end
end