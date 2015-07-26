require 'yaml'

module Vagrancy
  class FilestoreConfiguration


    def path
      path_maybe_no_traling_slash + (path_maybe_no_traling_slash[-1] == '/' ? '' : '/')
    end

    def path_maybe_no_traling_slash
      from_configuration_file || default
    end

    def from_configuration_file
      load_valid_filestore_path if File.exists? configuration_file_path 
    end

    def load_valid_filestore_path
      raise 'Path must be absolute' unless filestore_path_from_configuration[0] == '/'
      filestore_path_from_configuration
    end

    def filestore_path_from_configuration
      YAML.load(File.read(configuration_file_path))['filestore_path']
    end

    def configuration_file_path
      project_root + '/config.yml' 
    end

    def project_root
      File.expand_path(File.dirname(__FILE__) + '/../../') 
    end

    def default
      project_root + '/data'
    end
  end
end
