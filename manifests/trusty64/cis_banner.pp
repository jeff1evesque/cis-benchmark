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
  if ($cis_1_7_1_1) {
  }

  ## 1.7.1.2 Ensure local login warning banner is configured properly (Not Scored)
  if ($cis_1_7_1_2) {
  }

  ## 1.7.1.3 Ensure remote login warning banner is configured properly (Not Scored)
  if ($cis_1_7_1_3) {
  }

  ## 1.7.1.4 Ensure permissions on /etc/motd are configured (Not Scored)
  if ($cis_1_7_1_4) {
  }

  ## 1.7.1.5 Ensure permissions on /etc/issue are configured (Scored)
  if ($cis_1_7_1_5) {
  }

  ## 1.7.1.6 Ensure permissions on /etc/issue.net are configured (Not Scored)
  if ($cis_1_7_1_6) {
  }

  ## 1.7.2 Ensure GDM login banner is configured (Scored)
  if ($cis_1_7_2) {
  }

  ## 1.8 Ensure updates, patches, and additional security software are installed (Not Scored)
  if ($cis_1_8) {
  }
}
