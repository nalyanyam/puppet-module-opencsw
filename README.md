# OpenCSW
===

[![Build Status](https://travis-ci.org/juliengk/puppet-module-opencsw.png?branch=master)](https://travis-ci.org/juliengk/puppet-module-opencsw)

This is a Puppet module for managing OpenCSW pkgutil. It is capable of ensuring
pkgutil from OpenCSW installed, and specifying a mirror and some other
parameters.

===

# Compatibility
---------------
This module is built for use with Puppet v3 on the following platforms.

* Solaris 10

===

# Parameters
------------

## Resource parameters
---

proxy
-----

- *Default*: 'undef'

package_source
--------------

- *Default*: 'http://get.opencsw.org/now'

catalog_not_cached
------------------

- *Default*: 'UNSET'

catalog_update
--------------

- *Default*: 'UNSET'

deptree_filter_common
---------------------

- *Default*: 'UNSET'

exclude_pattern
---------------

- *Default*: 'UNSET'

gpg_homedir
-----------

- *Default*: 'UNSET'

maxpkglist
----------

- *Default*: 'UNSET'

mirrors
-------

- *Default*: 'USE_DEFAULTS'

noncsw
------

- *Default*: 'UNSET'

pkgaddopts
----------

- *Default*: 'UNSET'

pkgliststyle
------------

- *Default*: 'UNSET'

pkgrmopts
---------

- *Default*: 'UNSET'

root_path
---------

- *Default*: 'UNSET'

show_current
------------

- *Default*: 'UNSET'

stop_on_hook_soft_error
-----------------------

- *Default*: 'UNSET'

use_gpg
-------

- *Default*: 'UNSET'

use_md5
-------

- *Default*: 'UNSET'

wgetopts
--------

- *Default*: 'UNSET'
