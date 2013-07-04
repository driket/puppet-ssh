define mv_ssh::tools::authorized_keys (	$keys 	= ["sh-rsa AZERTYUIOP..."], 
																				$path 	= "/root/.ssh",
																				$user 	= "root",
																				$group 	= "root",
																			) 
{
	file {"${path}":
		ensure => directory,
	}
	
	file {"${path}/authorized_keys":
		ensure => file,
		owner => $user,
		group => $group,
		mode => "644",
		content => template("mv_ssh/authorized_keys.erb"),
		require => File["${path}"],
	}
}