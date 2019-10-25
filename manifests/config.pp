class dstrapp::config {
  Class[dstrapp::install] -> Class[dstrapp::config]

  group {
    'elasticsearch':
      ensure => 'present',
      gid    => '1000';
  }

  #https://puppet.com/docs/puppet/5.3/types/user.html
  user {
    'elasticsearch':
      ensure => 'present',
      uid    => '1000',
      shell  => '/sbin/nologin';
  }

  $elk_image_version = hiera('elk_image_version', '0.1.1')
  $elk_config_dir = hiera('elk_config_dir', '/var/lib/elasticsearch')

  file {

    '/etc/elk':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755';
    '/etc/elk/keys':
      ensure  => directory,
      source  => "puppet:///modules/dstrapp/keys",
      recurse => 'remote',
      path    => '/etc/elk/keys',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File['/etc/elk'];
    '/etc/elk/keys/audit':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File['/etc/elk/keys'];
    '/etc/elk/keys/logstash':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File['/etc/elk/keys'];
    '/etc/elk/keys/nginx':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File['/etc/elk/keys'];
    '/etc/elk/config':
      ensure  => directory,
      source  => "puppet:///modules/dstrapp/config",
      recurse => 'remote',
      path    => '/etc/elk/config',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File['/etc/elk'];

    '/etc/elk/keys/ca/stb_ca_cert.pem':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File['/etc/elk/keys'],
      source  => 'puppet:///modules/dstrapp/keys/ca/stb_ca_cert.pem';
    '/etc/elk/keys/ca/ca_cert.pem':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File['/etc/elk/keys'],
      source  => 'puppet:///modules/dstrapp/keys/ca/ca_cert.pem';


    '/etc/elk/keys/logstash/cert.pem':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/dstrapp/keys/ca/${::domain}.crt",
      require => File['/etc/elk/keys/logstash'];
    '/etc/elk/keys/logstash/key.pem':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => hiera('logstash_key'),
      require => File['/etc/elk/keys/logstash'];

    '/etc/elk/keys/nginx/cert.pem':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/dstrapp/keys/ca/${::domain}.crt",
      require => File['/etc/elk/keys/audit'];
    '/etc/elk/keys/nginx/key.pem':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => hiera('logstash_key'),
      require => File['/etc/elk/keys/nginx'];


    "/var/lib/elasticsearch/":
      ensure => directory,
      owner  => "elasticsearch",
      group  => "elasticsearch",
      mode   => '0755';

    '/var/lib/elasticsearch/bin':
      ensure  => directory,
      owner   => 'elasticsearch',
      group   => 'elasticsearch',
      mode    => '0755',
      require => File['/var/lib/elasticsearch/'];

    '/var/lib/elasticsearch/compositions':
      ensure  => directory,
      source  => "puppet:///modules/dstrapp/compositions",
      recurse => 'remote',
      path    => '/var/lib/elasticsearch/compositions',
      owner   => 'elasticsearch',
      group   => 'elasticsearch',
      mode    => '0755',
      require => File['/var/lib/elasticsearch/'];

    '/var/lib/elasticsearch/curate':
      ensure  => directory,
      source  => "puppet:///modules/dstrapp/curate",
      recurse => 'remote',
      path    => '/var/lib/elasticsearch/curate',
      owner   => 'elasticsearch',
      group   => 'elasticsearch',
      mode    => '0755',
      require => File['/var/lib/elasticsearch/'];
    "/var/lib/elasticsearch/logs/":
      ensure  => directory,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      require => File['/var/lib/elasticsearch/'];
    "/var/lib/elasticsearch/data/":
      ensure  => directory,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      require => File['/var/lib/elasticsearch/'];
    "/var/lib/elasticsearch/data/strapp/":
      ensure  => directory,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      require => File['/var/lib/elasticsearch/data/'];
    "/var/lib/elasticsearch/data/cross/":
      ensure  => directory,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      require => File['/var/lib/elasticsearch/data/'];
    "/var/lib/elasticsearch/data/generic/":
      ensure  => directory,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      require => File['/var/lib/elasticsearch/data/'];
    "/var/lib/elasticsearch/data/jetty/":
      ensure  => directory,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      require => File['/var/lib/elasticsearch/data/'];
    "/var/lib/elasticsearch/data/audit/":
      ensure  => directory,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      require => File['/var/lib/elasticsearch/data/'];
    "/var/lib/elasticsearch/bin/curate.sh":
      ensure  => present,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      content => template('dstrapp/bin/curate.sh.erb'),
      require => File['/var/lib/elasticsearch/bin'];
    "/var/lib/elasticsearch/env.sh":
      ensure  => present,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      content => template('dstrapp/env.sh.erb'),
      require => File['/var/lib/elasticsearch/bin'];
    "/var/lib/elasticsearch/bin/run.sh":
      ensure  => present,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      content => template('dstrapp/bin/run.sh.erb'),
      require => File['/var/lib/elasticsearch/bin'];
    "/var/lib/elasticsearch/bin/build_images.sh":
      ensure  => present,
      owner   => "elasticsearch",
      group   => "elasticsearch",
      mode    => '0755',
      content => template('dstrapp/bin/build_images.sh.erb'),
      require => File['/var/lib/elasticsearch/bin'];
    "/etc/sysctl.conf":
      ensure  => present,
      owner   => "root",
      group   => "root",
      mode    => "0644",
      source  => "puppet:///modules/dstrapp/sysctl.conf";
  }

  cron {
    dnanny-run:
      ensure  => present,
      command => "/var/lib/elasticsearch/bin/curate.sh > /var/lib/elasticsearch/logs/curate.log 2>&1",
      user    => root,
      hour    => '23',
      minute  => "17";
  }

}
