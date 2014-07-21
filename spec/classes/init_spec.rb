require 'spec_helper'

describe 'opencsw', :type => 'class' do

  describe 'pkgutil config content' do
    context 'with default params' do
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should compile.with_all_deps }

      it { should contain_class('opencsw') }

      it {
        should contain_file('pkgutil_conf').with({
          'ensure'  => 'file',
          'path'    => '/etc/opt/csw/pkgutil.conf',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'require' => 'Exec[pkgutil_install]',
        })
      }
    end

    context 'with catalog_not_cached parameter specified' do
      let(:params) { {
        :mirrors            => ['http://mirror.opencsw.org/opencsw/stable'],
        :catalog_not_cached => true,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^catalog_not_cached=true$/) }
    end

    context 'with catalog_update parameter specified' do
      let(:params) { {
        :mirrors        => ['http://mirror.opencsw.org/opencsw/stable'],
        :catalog_update => 14,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^catalog_update=14$/) }
    end

    context 'with deptree_filter_common parameter specified' do
      let(:params) { {
        :mirrors               => ['http://mirror.opencsw.org/opencsw/stable'],
        :deptree_filter_common => true,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^deptree_filter_common=true$/) }
    end

    context 'with exclude_pattern parameter specified' do
      let(:params) { {
        :mirrors         => ['http://mirror.opencsw.org/opencsw/stable'],
        :exclude_pattern => 'lsof',
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^exclude_pattern=lsof$/) }
    end

    context 'with gpg_homedir parameter specified' do
      let(:params) { {
        :mirrors     => ['http://mirror.opencsw.org/opencsw/stable'],
        :gpg_homedir => '/home/test/.gnupg',
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^gpg_homedir=\/home\/test\/\.gnupg$/) }
    end

    context 'with maxpkglist parameter specified' do
      let(:params) { {
        :mirrors    => ['http://mirror.opencsw.org/opencsw/stable'],
        :maxpkglist => 10000,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^maxpkglist=10000$/) }
    end

    context 'with noncsw parameter specified' do
      let(:params) { {
        :mirrors => ['http://mirror.opencsw.org/opencsw/stable'],
        :noncsw  => true,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^noncsw=true$/) }
    end

    context 'with pkgaddopts parameter specified' do
      let(:params) { {
        :mirrors    => ['http://mirror.opencsw.org/opencsw/stable'],
        :pkgaddopts => '-G -S',
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^pkgaddopts=-G -S$/) }
    end

    context 'with pkgliststyle parameter specified' do
      let(:params) { {
        :mirrors      => ['http://mirror.opencsw.org/opencsw/stable'],
        :pkgliststyle => 1,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^pkgliststyle=1$/) }
    end

    context 'with pkgrmopts parameter specified' do
      let(:params) { {
        :mirrors   => ['http://mirror.opencsw.org/opencsw/stable'],
        :pkgrmopts => '-O nozones',
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^pkgrmopts=-O nozones$/) }
    end

    context 'with root_path parameter specified' do
      let(:params) { {
        :mirrors   => ['http://mirror.opencsw.org/opencsw/stable'],
        :root_path => '/a',
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^root_path=\/a$/) }
    end

    context 'with show_current parameter specified' do
      let(:params) { {
        :mirrors      => ['http://mirror.opencsw.org/opencsw/stable'],
        :show_current => true,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^show_current=true$/) }
    end

    context 'with stop_on_hook_soft_error parameter specified' do
      let(:params) { {
        :mirrors                 => ['http://mirror.opencsw.org/opencsw/stable'],
        :stop_on_hook_soft_error => true,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^stop_on_hook_soft_error=true$/) }
    end

    context 'with use_gpg parameter specified' do
      let(:params) { {
        :mirrors => ['http://mirror.opencsw.org/opencsw/stable'],
        :use_gpg => true,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^use_gpg=true$/) }
    end

    context 'with use_md5 parameter specified' do
      let(:params) { {
        :mirrors => ['http://mirror.opencsw.org/opencsw/stable'],
        :use_md5 => true,
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^use_md5=true$/) }
    end

    context 'with wgetopts parameter specified' do
      let(:params) { {
        :mirrors  => ['http://mirror.opencsw.org/opencsw/stable'],
        :wgetopts => '-U pkgutil',
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should contain_file('pkgutil_conf').with_content(/^wgetopts=-U pkgutil$/) }
    end
  end

  describe 'opencsw package installation' do
    context 'with default params' do
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should compile.with_all_deps }

      it { should contain_class('opencsw') }

      it {
        should contain_file('pkgutil_admin_file').with({
          'ensure' => 'file',
          'path'   => '/var/sadm/install/admin/opencsw-noask',
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0644',
        })
      }

      it {
        should contain_exec('pkgutil_install').with({
          'command' => "/usr/bin/echo all | /usr/sbin/pkgadd  -a /var/sadm/install/admin/opencsw-noask -d http://get.opencsw.org/now",
          'require' => 'File[pkgutil_admin_file]',
          'unless'  => '/usr/bin/test -f /opt/csw/bin/pkgutil',
        })
      }
    end

    context 'with proxy param' do
      let(:params) { {
        :proxy => 'proxy.example.net:8080',
      } }
      let(:facts) { {
        :osfamily      => 'Solaris',
        :kernelrelease => '5.10',
      } }

      it { should compile.with_all_deps }

      it { should contain_class('opencsw') }

      it {
        should contain_file('pkgutil_admin_file').with({
          'ensure' => 'file',
          'path'   => '/var/sadm/install/admin/opencsw-noask',
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0644',
        })
      }

      it {
        should contain_exec('pkgutil_install').with({
          'command' => "/usr/bin/echo all | /usr/sbin/pkgadd -x proxy.example.net:8080 -a /var/sadm/install/admin/opencsw-noask -d http://get.opencsw.org/now",
          'require' => 'File[pkgutil_admin_file]',
          'unless'  => '/usr/bin/test -f /opt/csw/bin/pkgutil',
        })
      }
    end
  end

  describe 'opencsw osfamily validation' do
    context 'on unsupported osfamily, RedHat' do
      let(:facts) { { :osfamily => 'RedHat' } }

      it {
        expect {
          should contain_class('opencsw')
        }.to raise_error(Puppet::Error, /opencsw supports osfamily Solaris. Detected osfamily is <RedHat>./)
      }
    end
  end
end
