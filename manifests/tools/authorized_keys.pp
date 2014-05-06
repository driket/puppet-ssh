define mv_ssh::tools::authorized_keys (
  $keys   = ["ssh-rsa AZERTYUIOP..."],
  $owner  = "root",
  $group  = "root",
)
{

  case $owner {

    'root': {

      file {'mv_ssh_home':
        ensure  => directory,
        name    => '/root',
      }

      file {'mv_ssh_home_ssh':
        ensure  => directory,
        name    => '/root/.ssh',
        mode    => '0600',
        owner   => $owner,
        group   => $group,
      }

      file {'mv_ssh_authorized_keys':
        ensure  => file,
        name    => '/root/.ssh/authorized_keys',
        owner   => $owner,
        group   => $group,
        mode    => '0600',
        content => template('mv_ssh/authorized_keys.erb'),
        require => File['mv_ssh_home_ssh'],
      }

    }

    default: {

      file {'mv_ssh_home':
        ensure  => directory,
        name    => "/home/${owner}",
      }

      file {'mv_ssh_home_ssh':
        ensure  => directory,
        name    => "/home/${owner}/.ssh",
        mode    => '0600',
        owner   => $owner,
        group   => $group,
      }

      file {'mv_ssh_authorized_keys':
        ensure  => file,
        name    => "/home/${owner}/.ssh/authorized_keys",
        owner   => $owner,
        group   => $group,
        mode    => '0600',
        content => template('mv_ssh/authorized_keys.erb'),
        require => File["/home/${owner}/.ssh"],
      }

    }
  }



}