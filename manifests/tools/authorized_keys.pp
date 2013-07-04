define mv_ssh::tools::authorized_keys (	$keys 	= ["sh-rsa AZERTYUIOP..."], 
																				$path 	= "/root/.ssh",
																				$owner 	= "root",
																				$group 	= "root",
																			) 
{
	file {"${path}":
		ensure 	=> directory,
		mode 		=> "600", 
	}
	
	file {"${path}/authorized_keys":
		ensure 	=> file,
		owner 	=> $owner,
		group 	=> $group,
		mode 		=> "600",
		content => template("mv_ssh/authorized_keys.erb"),
		require => File["${path}"],
	}
}