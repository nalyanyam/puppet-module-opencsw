
class opencsw (
  $proxy                   = undef,
  $package_source          = 'http://get.opencsw.org/now',
  $catalog_not_cached      = true,
  $catalog_update          = 14,
  $deptree_filter_common   = false,
  $exclude_pattern         = undef,
  $gpg_homedir             = undef,
  $maxpkglist              = 100000,
  $mirrors                 = undef,
  $noncsw                  = false,
  $pkgaddopts              = undef,
  $pkgliststyle            = 2,
  $pkgrmopts               = undef,
  $root_path               = '/',
  $show_current            = true,
  $stop_on_hook_soft_error = false,
  $use_gpg                 = false,
  $use_md5                 = false,
  $wgetopts                = undef,
) {

  validate_string($proxy)

  validate_string($package_source)

  if type($catalog_not_cached) == 'String' {
    $catalog_not_cached_real = str2bool($catalog_not_cached)
  } else {
    $catalog_not_cached_real = $catalog_not_cached
  }
  validate_bool($catalog_not_cached_real)

  validate_re($catalog_update, '^(\d)+$',
    "opencsw::catalog_update is <${catalog_update}>. Must be a number.")

  if type($deptree_filter_common) == 'String' {
    $deptree_filter_common_real = str2bool($deptree_filter_common)
  } else {
    $deptree_filter_common_real = $deptree_filter_common
  }
  validate_bool($deptree_filter_common_real)

  validate_string($exclude_pattern)

  if $gpg_homedir != undef {
    validate_absolute_path($gpg_homedir)
  }

  validate_re($maxpkglist, '^(\d)+$',
    "opencsw::maxpkglist is <${maxpkglist}>. Must be a number.")

  if type($noncsw) == 'String' {
    $noncsw_real = str2bool($noncsw)
  } else {
    $noncsw_real = $noncsw
  }
  validate_bool($noncsw_real)

  validate_string($pkgaddopts)

  validate_re($pkgliststyle, '^(\d)+$',
    "opencsw::pkgliststyle is <${pkgliststyle}>. Must be a number.")

  validate_string($pkgrmopts)

  if $root_path != undef {
    validate_absolute_path($root_path)
  }

  if type($show_current) == 'String' {
    $show_current_real = str2bool($show_current)
  } else {
    $show_current_real = $show_current
  }
  validate_bool($show_current_real)

  if type($stop_on_hook_soft_error) == 'String' {
    $stop_on_hook_soft_error_real = str2bool($stop_on_hook_soft_error)
  } else {
    $stop_on_hook_soft_error_real = $stop_on_hook_soft_error
  }
  validate_bool($stop_on_hook_soft_error_real)

  if type($use_gpg) == 'String' {
    $use_gpg_real = str2bool($use_gpg)
  } else {
    $use_gpg_real = $use_gpg
  }
  validate_bool($use_gpg_real)

  if type($use_md5) == 'String' {
    $use_md5_real = str2bool($use_md5)
  } else {
    $use_md5_real = $use_md5
  }
  validate_bool($use_md5_real)

  validate_string($wgetopts)

  if $proxy {
    $proxy_opt = "-x ${proxy}"
  }

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { 'pkgutil_admin_file':
    path   => '/var/sadm/install/admin/opencsw-noask',
    ensure => 'file',
    source => 'puppet:///modules/opencsw/opencsw-noask',
  }

  exec { 'pkgutil_install':
    command => "/usr/bin/echo all | /usr/sbin/pkgadd ${proxy_opt} -a /var/sadm/install/admin/opencsw-noask -d ${package_source}",
    require => File['pkgutil_admin_file'],
    unless  => '/usr/bin/test -f /opt/csw/bin/pkgutil',
  }

  file { 'pkgutil_conf':
    path    => '/etc/opt/csw/pkgutil.conf',
    ensure  => file,
    content => template('opencsw/pkgutil.conf.erb'),
    require => Exec['pkgutil_install'],
  }

  file { 'pkgutil_conf_opt':
    path    => '/opt/csw/etc/pkgutil.conf',
    ensure  => 'symlink',
    target  => '/etc/opt/csw/pkgutil.conf',
    require => Exec['pkgutil_install'],
  }
}
