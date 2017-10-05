## CIS Ubuntu 14.04 LTS Server Benchmark
## v2.0.0 - 09-30-2016
##
## https://github.com/jeff1evesque/machine-learning/files/629747/CIS_Ubuntu_Linux_14.04_LTS_Benchmark_v2.0.0.pdf
##

class cis::trusty64::cis_banner {
  ## local variables: conditionally load hiera
  ##
  ## Note: yaml keys cannot contain '.', so regsubst() is used. Likewise, the
  ##       corresponding yaml key, implements underscores instead of '.' for
  ##       nodes certificate name.
  ##
  $hiera_node    = lookup([
      regsubst($trusted['certname'], '\.', '_', 'G'),
      'trusty64'
  ])
  $stig          = $hiera_node['stig']
  $account       = hiera('account')
  $grub_user     = $stig['grub2']['user']
  $grub_password = $stig['grub2']['password']
  $root_password = $stig['account']['root']['password']

  ## local variables: stig items
  $cis_1_7_1_1     = $stig['cis_1_7_1_1']
  $cis_1_7_1_2     = $stig['cis_1_7_1_2']
  $cis_1_7_1_3     = $stig['cis_1_7_1_3']
  $cis_1_7_1_4     = $stig['cis_1_7_1_4']
  $cis_1_7_1_5     = $stig['cis_1_7_1_5']
  $cis_1_7_1_6     = $stig['cis_1_7_1_6']
  $cis_1_7_2       = $stig['cis_1_7_2']
  $cis_1_8         = $stig['cis_1_8']

  ## 1.7.1.1 Ensure message of the day is configured properly (Scored)
  ## 1.7.1.4 Ensure permissions on /etc/motd are configured (Not Scored)
  if ($cis_1_7_1_1 and $cis_1_7_1_4) {
    file { '/etc/motd':
      ensure  => present,
      mode    => '0444',
      owner   => 'root',
      group   => 'root',
      content => dos2unix(template('cis/trusty64/motd.erb')),
    }
  }
  elsif ($cis_1_7_1_1) {
    file { '/etc/motd':
      ensure  => present,
      content => dos2unix(template('cis/trusty64/motd.erb')),
    }
  }
  elsif ($cis_1_7_1_4) {
    file { '/etc/motd':
      ensure  => present,
      mode    => '0444',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## 1.7.1.2 Ensure local login warning banner is configured properly (Not Scored)
  ## 1.7.1.5 Ensure permissions on /etc/issue are configured (Scored)
  if ($cis_1_7_1_2 and $cis_1_7_1_5) {
    file { '/etc/issue':
      ensure  => present,
      mode    => '0444',
      owner   => 'root',
      group   => 'root',
      content => dos2unix(template('cis/trusty64/issues.erb')),
    }
  }
  elsif ($cis_1_7_1_2) {
    file { '/etc/issue':
      ensure  => present,
      content => dos2unix(template('cis/trusty64/issues.erb')),
    }
  }
  elsif ($cis_1_7_1_5) {
    file { '/etc/issue':
      ensure  => present,
      mode    => '0444',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## 1.7.1.3 Ensure remote login warning banner is configured properly (Not Scored)
  ## 1.7.1.6 Ensure permissions on /etc/issue.net are configured (Not Scored)
  if ($cis_1_7_1_3 and $cis_1_7_1_6) {
    file { '/etc/issue.net':
      ensure  => present,
      mode    => '0444',
      owner   => 'root',
      group   => 'root',
      content => dos2unix(template('cis/trusty64/issues.erb')),
    }
  }
  elsif ($cis_1_7_1_3) {
    file { '/etc/issue.net':
      ensure  => present,
      content => dos2unix(template('cis/trusty64/issues.erb')),
    }
  }
  elsif ($cis_1_7_1_6) {
    file { '/etc/issue.net':
      ensure  => present,
      mode    => '0444',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## 1.7.2 Ensure GDM login banner is configured (Scored)
  if ($cis_1_7_2) {
    package { 'gdm':
      ensure      => present,
    }

    file { '/etc/dconf/profile/gdm':
      ensure      => present,
      mode        => '0644',
      owner       => 'root',
      group       => 'root',
      content     => dos2unix(template('cis/trusty64/issues.erb')),
      require     => Package['gdm'],
      notify      => Exec['update-system-database'],
    }

    file { '/etc/dconf/db/gdm.d/01-banner-message':
      ensure      => present,
      mode        => '0644',
      owner       => 'root',
      group       => 'root',
      content     => dos2unix(template('cis/trusty64/issues.erb')),
      require     => Package['gdm'],
      notify      => Exec['update-system-database'],
    }

    exec { 'update-system-database':
      command     => 'dconf update',
      path        => '/usr/bin',
      refreshonly => true,
    }
  }

  ## 1.8 Ensure updates, patches, and additional security software are installed (Not Scored)
  if ($cis_1_8) {
  }
}
