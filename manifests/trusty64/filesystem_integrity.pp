##
## CIS Ubuntu 14.04 LTS Server Benchmark
## v2.0.0 - 09-30-2016
##
## https://github.com/jeff1evesque/machine-learning/files/629747/CIS_Ubuntu_Linux_14.04_LTS_Benchmark_v2.0.0.pdf
##

class cis_benchmark::trusty64::filesystem_integrity {
  ## local variables
  $aide_logdir      = '/var/log/aide'
  $aide_logfile     = "${aide_logdir}/`date +%Y.%m.%d.%H.%M.%S`_aidecheck.txt"

  ## local variables: stig items
  $cis_1_3_1        = $::cis_benchmark::cis_1_3_1
  $cis_1_3_2        = $::cis_benchmark::cis_1_3_2

  ## 1.3.1 Ensure AIDE is installed (Scored)
  if ($cis_1_3_1) {
    package { 'aide':
        ensure      => 'installed',
        notify      => Exec['aideinit'],
    }

    exec { 'aideinit':
        command     => 'apt-get -y update && aideinit',
        refreshonly => true,
        path        => ['/bin', '/usr/sbin', '/usr/bin'],
    }
  }

  ## 1.3.2 Ensure filesystem integrity is regularly checked (Scored)
  if ($cis_1_3_2) {
      file { $aide_logdir:
          ensure    => 'directory',
          owner     => 'root',
          group     => 'root',
          mode      => '0700',
      }

      cron::daily { 'aide-report':
          command   => "aide -c /etc/aide/aide.conf --check > ${aide_logfile}",
          user      => 'root',
          hour      => '5',
          minute    => '0',
      }
  }
}
