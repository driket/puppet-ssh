# Setup user's authorized keys
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file
define mv_ssh::tools::authorized_keys (
  $keys   = ['ssh-rsa AZERTYUIOP...'],
  $owner  = 'root',
  $group  = 'root',
)
{
  # Check if owner is root or not
  case $owner {

    'root': {

      file {"mv_ssh_${owner}_home_ssh":
        ensure  => directory,
        path    => '/root/.ssh',
        mode    => '0600',
        owner   => $owner,
        group   => $group,
      }

      file {"mv_ssh_${owner}_authorized_keys":
        ensure  => file,
        path    => '/root/.ssh/authorized_keys',
        owner   => $owner,
        group   => $group,
        mode    => '0600',
        content => template('mv_ssh/authorized_keys.erb'),
        require => File["mv_ssh_${owner}_home_ssh"],
      }

    }

    default: {

      file {"mv_ssh_${owner}_home_ssh":
        ensure  => directory,
        path    => "/home/${owner}/.ssh",
        mode    => '0600',
        owner   => $owner,
        group   => $group,
      }

      file {"mv_ssh_${owner}_authorized_keys":
        ensure  => file,
        path    => "/home/${owner}/.ssh/authorized_keys",
        owner   => $owner,
        group   => $group,
        mode    => '0600',
        content => template('mv_ssh/authorized_keys.erb'),
        require => File["mv_ssh_${owner}_home_ssh"],
      }

    }
  }

}
