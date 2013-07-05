define mv_ssh::tools::authorized_keys (	$keys 	= ["ssh-rsa AZERTYUIOP..."], 
																				$path 	= "/root/.ssh",
																				$owner 	= "root",
																				$group 	= "root",
																			) 
{
	file {"${path}":
		ensure 	=> directory,
		mode 		=> "0600", 
	}
	
	file {"${path}/authorized_keys":
		ensure 	=> file,
		owner 	=> $owner,
		group 	=> $group,
		mode 		=> "0600",
		content => template("mv_ssh/authorized_keys.erb"),
		require => File["${path}"],
	}
}