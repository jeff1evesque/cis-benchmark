# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  ## variables
  ##
  ## Note: multiple vagrant plugins follow the following syntax:
  ##
  ##        required_plugins = %w(plugin1 plugin2 plugin3)
  ##
  required_plugins  = %w(vagrant-r10k vagrant-triggers)
  plugin_installed  = false
  ENV['TEST_ENV']  = 'Trusty64'

  ## Install Vagrant Plugins
  required_plugins.each do |plugin|
    unless Vagrant.has_plugin? plugin
      system "vagrant plugin install #{plugin}"
      plugin_installed = true
    end
  end

  ## Restart Vagrant: if new plugin installed
  if plugin_installed == true
    exec "vagrant #{ARGV.join(' ')}"
  end

 if ENV['TEST_ENV'] == 'Trusty64'

    atlas_repo  = 'jeff1evesque'
    atlas_box   = 'trusty64'
    box_version = '1.0.0'

    config.vm.box                        = "#{atlas_repo}/#{atlas_box}"
    config.vm.box_url                    = "https://atlas.hashicorp.com/#{atlas_repo}/boxes/#{atlas_box}/versions/#{box_version}/providers/virtualbox.box"
    config.vm.box_download_checksum      = 'c26da6ba1c169bdc6e9168125ddb0525'
    config.vm.box_download_checksum_type = 'md5'

  end

  ## Ensure puppet installed within guest
  config.puppet_install.puppet_version = '4.3.2'

  ## increase RAM to ensure scrypt doesn't exhaust memory
  config.vm.provider 'virtualbox' do |v|
    v.customize ['modifyvm', :id, '--memory', '512']
  end
end