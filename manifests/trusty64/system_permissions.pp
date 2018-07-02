##
## CIS Ubuntu 14.04 LTS Server Benchmark
## v2.0.0 - 09-30-2016
##
## https://github.com/jeff1evesque/machine-learning/files/629747/CIS_Ubuntu_Linux_14.04_LTS_Benchmark_v2.0.0.pdf
##

class cis::trusty64::system_permissions {
  ## local variables
  $exec_path     = $::cis_benchmark::exec_path
  $report_path   = $::cis_benchmark::report_path
  $paths         = $::cis_benchmark::paths
  $valid_suid    = $::cis_benchmark::suid
  $valid_sgid    = $::cis_benchmark::sgid

  ## local variables: stig items
  $6_1_1         = $::cis_benchmark::6_1_1
  $6_1_2         = $::cis_benchmark::6_1_2
  $6_1_3         = $::cis_benchmark::6_1_3
  $6_1_4         = $::cis_benchmark::6_1_4
  $6_1_5         = $::cis_benchmark::6_1_5
  $6_1_6         = $::cis_benchmark::6_1_6
  $6_1_7         = $::cis_benchmark::6_1_7
  $6_1_8         = $::cis_benchmark::6_1_8
  $6_1_9         = $::cis_benchmark::6_1_9
  $6_1_10        = $::cis_benchmark::6_1_10
  $6_1_11        = $::cis_benchmark::6_1_11
  $6_1_12        = $::cis_benchmark::6_1_12
  $6_1_13        = $::cis_benchmark::6_1_13
  $6_1_14        = $::cis_benchmark::6_1_14

  ## CIS 6.1.1 Audit system file permissions (Not Scored)
  if ($6_1_1) {
    file { 'file-cis-6-1-1':
        path     => "${exec_path}/dpkg-report",
        content  => dos2unix(template('cis/trusty64/bash/dpkg-report.erb')),
        owner    => root,
        group    => root,
        mode     => '0700',
    }

    exec { 'exec-cis-6-1-1':
        command  => './dpkg-report execute',
        cwd      => $exec_path,
        onlyif   => './dpkg-report check',
        path     => '/usr/bin',
        provider => shell,
    }
  }

  ## CIS 6.1.2 Ensure permissions on /etc/passwd are configured (Scored)
  if ($6_1_2) {
    file { '/etc/passwd':
      ensure  => present,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## CIS 6.1.3 Ensure permissions on /etc/shadow are configured (Scored)
  if ($6_1_3) {
    file { '/etc/shadow':
      ensure  => present,
      mode    => '0640',
      owner   => 'root',
      group   => 'shadow',
    }
  }

  ## CIS 6.1.4 Ensure permissions on /etc/group are configured (Scored)
  if ($6_1_4) {
    file { '/etc/group':
      ensure  => present,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## CIS 6.1.5 Ensure permissions on /etc/gshadow are configured (Scored)
  if ($6_1_5) {
    file { '/etc/gshadow':
      ensure  => present,
      mode    => '0640',
      owner   => 'root',
      group   => 'shadow',
    }
  }

  ## CIS 6.1.6 Ensure permissions on /etc/passwd- are configured (Scored)
  if ($6_1_6) {
    file { '/etc/passwd-':
      ensure  => present,
      mode    => '0700',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## CIS 6.1.7 Ensure permissions on /etc/shadow- are configured (Scored)
  if ($6_1_7) {
    file { '/etc/shadow-':
      ensure  => present,
      mode    => '0700',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## CIS 6.1.8 Ensure permissions on /etc/group- are configured (Scored)
  if ($6_1_8) {
    file { '/etc/group-':
      ensure  => present,
      mode    => '0700',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## CIS 6.1.9 Ensure permissions on /etc/gshadow- are configured (Scored)
  if ($6_1_9) {
    file { '/etc/gshadow-':
      ensure  => present,
      mode    => '0700',
      owner   => 'root',
      group   => 'root',
    }
  }

  ## CIS 6.1.10 Ensure no world writable files exist (Scored)
  if ($6_1_10) {
    file { 'file-cis-6-1-10':
        path     => "${exec_path}/world-writeable-files",
        content  => dos2unix(template('cis/trusty64/bash/world-writeable-files.erb')),
        owner    => root,
        group    => root,
        mode     => '0700',
    }

    exec { 'exec-cis-6-1-10':
        command  => './world-writeable-files execute',
        cwd      => $exec_path,
        path     => [
            '/bin',
            '/usr/bin',
            '/usr/sbin',
        ],
        onlyif   => './world-writeable-files check',
        provider => shell,
    }
  }

  ## CIS 6.1.11 Ensure no unowned files or directories exist (Scored)
  if ($6_1_11) {
    file { 'file-cis-6-1-11':
        path     => "${exec_path}/unowned-files",
        content  => dos2unix(template('cis/trusty64/bash/unowned-files.erb')),
        owner    => root,
        group    => root,
        mode     => '0700',
    }

    exec { 'exec-cis-6-1-11':
        command  => './unowned-files execute',
        cwd      => $exec_path,
        path     => [
            '/bin',
            '/usr/bin',
            '/usr/sbin',
        ],
        onlyif   => './unowned-files check',
        provider => shell,
    }
  }

  ## CIS 6.1.12 Ensure no ungrouped files or directories exist (Scored)
  if ($6_1_12) {
    file { 'file-cis-6-1-12':
        path     => "${exec_path}/ungrouped-files",
        content  => dos2unix(template('cis/trusty64/bash/ungrouped-files.erb')),
        owner    => root,
        group    => root,
        mode     => '0700',
    }

    exec { 'exec-cis-6-1-12':
        command  => './ungrouped-files execute',
        cwd      => $exec_path,
        path     => [
            '/bin',
            '/usr/bin',
            '/usr/sbin',
        ],
        onlyif   => './ungrouped-files check',
        provider => shell,
    }
  }

  ## CIS 6.1.13 Audit SUID executables (Not Scored)
  if ($6_1_13) {
    file { 'file-cis-6-1-13':
        path     => "${exec_path}/suid-executables",
        content  => dos2unix(template('cis/trusty64/bash/suid-executables.erb')),
        owner    => root,
        group    => root,
        mode     => '0700',
    }

    exec { 'exec-cis-6-1-13':
        command  => './suid-executables execute',
        cwd      => $exec_path,
        path     => [
            '/bin',
            '/usr/bin',
            '/usr/sbin',
        ],
        onlyif   => './suid-executables check',
        provider => shell,
    }
  }

  ## CIS 6.1.14 Audit SGID executables (Not Scored)
  if ($6_1_14) {
    file { 'file-cis-6-1-14':
        path     => "${exec_path}/sgid-executables",
        content  => dos2unix(template('cis/trusty64/bash/sgid-executables.erb')),
        owner    => root,
        group    => root,
        mode     => '0700',
    }

    exec { 'exec-cis-6-1-14':
        command  => './sgid-executables execute',
        cwd      => $exec_path,
        path     => [
            '/bin',
            '/usr/bin',
            '/usr/sbin',
        ],
        onlyif   => './sgid-executables check',
        provider => shell,
    }
  }
}
