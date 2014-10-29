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

- *Default*: 'true'

catalog_update
--------------

- *Default*: 14

deptree_filter_common
---------------------

- *Default*: 'false'

exclude_pattern
---------------

- *Default*: 'undef'

gpg_homedir
-----------

- *Default*: 'undef'

maxpkglist
----------

- *Default*: 100000

mirrors
-------

- *Default*: 'USE_DEFAULTS'

noncsw
------

- *Default*: 'false'

pkgaddopts
----------

- *Default*: 'undef'

pkgliststyle
------------

- *Default*: 2

pkgrmopts
---------

- *Default*: 'undef'

root_path
---------

- *Default*: '/'

show_current
------------

- *Default*: 'true'

stop_on_hook_soft_error
-----------------------

- *Default*: 'false'

use_gpg
-------

- *Default*: 'false'

use_md5
-------

- *Default*: 'false'

wgetopts
--------

- *Default*: 'undef'
