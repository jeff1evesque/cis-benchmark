##
## CIS Ubuntu 14.04 LTS Server Benchmark
## v2.0.0 - 09-30-2016
##
## https://github.com/jeff1evesque/machine-learning/files/629747/CIS_Ubuntu_Linux_14.04_LTS_Benchmark_v2.0.0.pdf
##

class cis::trusty64::filesystems {
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

  ## local variables: stig items
  $cis_1_1_1_1     = $stig['cis_1_1_1_1']
  $cis_1_1_1_2     = $stig['cis_1_1_1_2']
  $cis_1_1_1_3     = $stig['cis_1_1_1_3']
  $cis_1_1_1_4     = $stig['cis_1_1_1_4']
  $cis_1_1_1_5     = $stig['cis_1_1_1_5']
  $cis_1_1_1_6     = $stig['cis_1_1_1_6']
  $cis_1_1_1_7     = $stig['cis_1_1_1_7']
  $cis_1_1_1_8     = $stig['cis_1_1_1_8']

  ## 1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Scored)
  ## 1.1.1.2 Ensure mounting of freevxfs filesystems is disabled (Scored)
  ## 1.1.1.3 Ensure mounting of jffs2 filesystems is disabled (Scored)
  ## 1.1.1.4 Ensure mounting of hfs filesystems is disabled (Scored)
  ## 1.1.1.5 Ensure mounting of hfsplus filesystems is disabled (Scored)
  ## 1.1.1.6 Ensure mounting of squashfs filesystems is disabled (Scored)
  ## 1.1.1.7 Ensure mounting of udf filesystems is disabled (Scored)
  ## 1.1.1.8 Ensure mounting of FAT filesystems is disabled (Scored)
  ##
  if (
      $cis_1_1_1_1 or
      $cis_1_1_1_2 or
      $cis_1_1_1_3 or
      $cis_1_1_1_4 or
      $cis_1_1_1_5 or
      $cis_1_1_1_6 or
      $cis_1_1_1_7 or
      $cis_1_1_1_8
  ) {
    file { 'file-cis-1-1-1':
        content  => dos2unix(template('cis/trusty64/CIS.conf.erb')),
        path     => '/etc/modprobe.d/CIS.conf',
        mode     => '0644',
        owner    => root,
        group    => root,
    }
  }
}