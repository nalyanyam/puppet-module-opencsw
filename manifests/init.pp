# == Class: opencsw
#
# Module to manage opencsw repository for Solaris
#
class opencsw (
  $proxy                   = undef,
  $package_source          = 'http://get.opencsw.org/now',
  $catalog_not_cached      = 'UNSET',
  $catalog_update          = 'UNSET',
  $deptree_filter_common   = 'UNSET',
  $exclude_pattern         = 'UNSET',
  $gpg_homedir             = 'UNSET',
  $maxpkglist              = 'UNSET',
  $mirrors                 = 'USE_DEFAULTS',
  $noncsw                  = 'UNSET',
  $pkgaddopts              = 'UNSET',
  $pkgliststyle            = 'UNSET',
  $pkgrmopts               = 'UNSET',
  $root_path               = 'UNSET',
  $show_current            = 'UNSET',
  $stop_on_hook_soft_error = 'UNSET',
  $use_gpg                 = 'UNSET',
  $use_md5                 = 'UNSET',
  $wgetopts                = 'UNSET',
) {

  if $::osfamily == 'Solaris' {
    if $::kernelrelease != '5.10' {
      fail("opencsw is only supported on Solaris 5.10. Your kernelrelease is identified as <${::kernelrelease}>.")
    }
  }
  else {
    fail("opencsw supports osfamily Solaris. Detected osfamily is <${::osfamily}>.")
  }

  validate_string($proxy)

  validate_string($package_source)

  if $catalog_not_cached != 'UNSET' {
    if type($catalog_not_cached) == 'String' {
      $catalog_not_cached_real = str2bool($catalog_not_cached)
    } else {
      $catalog_not_cached_real = $catalog_not_cached
    }
    validate_bool($catalog_not_cached_real)
  }

  if $catalog_update != 'UNSET' {
    validate_re($catalog_update, '^(\d)+$',
      "opencsw::catalog_update is <${catalog_update}>. Must be a number.")
  }

  if $deptree_filter_common != 'UNSET' {
    if type($deptree_filter_common) == 'String' {
      $deptree_filter_common_real = str2bool($deptree_filter_common)
    } else {
      $deptree_filter_common_real = $deptree_filter_common
    }
    validate_bool($deptree_filter_common_real)
  }

  if $exclude_pattern != 'UNSET' {
    validate_string($exclude_pattern)
  }

  if $gpg_homedir != 'UNSET' {
    validate_absolute_path($gpg_homedir)
  }

  if $maxpkglist != 'UNSET' {
    validate_re($maxpkglist, '^(\d)+$',
      "opencsw::maxpkglist is <${maxpkglist}>. Must be a number.")
  }

  if $mirrors == 'USE_DEFAULTS' {
    $mirrors_real = [ 'http://mirror.opencsw.org/opencsw/testing' ]
  } else {
    $mirrors_real = $mirrors
  }
  validate_array($mirrors_real)

  if $noncsw != 'UNSET' {
    if type($noncsw) == 'String' {
      $noncsw_real = str2bool($noncsw)
    } else {
      $noncsw_real = $noncsw
    }
    validate_bool($noncsw_real)
  }

  if $pkgaddopts != 'UNSET' {
    validate_string($pkgaddopts)
  }

  if $pkgliststyle != 'UNSET' {
    validate_re($pkgliststyle, '^(\d)+$',
      "opencsw::pkgliststyle is <${pkgliststyle}>. Must be a number.")
  }

  if $pkgrmopts != 'UNSET' {
    validate_string($pkgrmopts)
  }

  if $root_path != 'UNSET' {
    validate_absolute_path($root_path)
  }

  if $show_current != 'UNSET' {
    if type($show_current) == 'String' {
      $show_current_real = str2bool($show_current)
    } else {
      $show_current_real = $show_current
    }
    validate_bool($show_current_real)
  }

  if $stop_on_hook_soft_error != 'UNSET' {
    if type($stop_on_hook_soft_error) == 'String' {
      $stop_on_hook_soft_error_real = str2bool($stop_on_hook_soft_error)
    } else {
      $stop_on_hook_soft_error_real = $stop_on_hook_soft_error
    }
    validate_bool($stop_on_hook_soft_error_real)
  }

  if $use_gpg != 'UNSET' {
    if type($use_gpg) == 'String' {
      $use_gpg_real = str2bool($use_gpg)
    } else {
      $use_gpg_real = $use_gpg
    }
    validate_bool($use_gpg_real)
  }

  if $use_md5 != 'UNSET' {
    if type($use_md5) == 'String' {
      $use_md5_real = str2bool($use_md5)
    } else {
      $use_md5_real = $use_md5
    }
    validate_bool($use_md5_real)
  }

  if $wgetopts != 'UNSET' {
    validate_string($wgetopts)
  }

  if $proxy {
    $proxy_opt = "-x ${proxy}"
  } else {
    $proxy_opt = undef
  }

  file { 'pkgutil_admin_file':
    ensure => 'file',
    path   => '/var/sadm/install/admin/opencsw-noask',
    source => 'puppet:///modules/opencsw/opencsw-noask',
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  exec { 'pkgutil_install':
    command => "/usr/bin/echo all | /usr/sbin/pkgadd ${proxy_opt} -a /var/sadm/install/admin/opencsw-noask -d ${package_source}",
    require => File['pkgutil_admin_file'],
    unless  => '/usr/bin/test -f /opt/csw/bin/pkgutil',
  }

  file { 'pkgutil_conf':
    ensure  => file,
    path    => '/etc/opt/csw/pkgutil.conf',
    content => template('opencsw/pkgutil.conf.erb'),
    owner => 'root',
    group => 'root',
    mode  => '0644',
    require => Exec['pkgutil_install'],
  }
}
