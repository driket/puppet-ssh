define mv_ssh::tools::authorized_keys (	
	$keys 	= ["ssh-rsa AZERTYUIOP..."], 
	$owner 	= "root",
	$group 	= "root",
) 
{
	
	case $owner {

		'root': {

			file {"/root":
				ensure 	=> directory,
			}
			
			file {"/root/.ssh":
				ensure 	=> directory,
				mode 		=> "0600", 
				owner		=> $owner,
				group 	=> $group,
			}
			
			file {"/root/.ssh/authorized_keys":
				ensure 	=> file,
				owner 	=> $owner,
				group 	=> $group,
				mode 		=> "0600",
				content => template("mv_ssh/authorized_keys.erb"),
				require => File["/root/.ssh"],
			}

		}
		
    default: {
			
			file {"/home/${owner}":
				ensure 	=> directory,
			}
			
			file {"/home/${owner}/.ssh":
				ensure 	=> directory,
				mode 		=> "0600", 
				owner		=> $owner,
				group 	=> $group,
			}
			
			file {"/home/${owner}/.ssh/authorized_keys":
				ensure 	=> file,
				owner 	=> $owner,
				group 	=> $group,
				mode 		=> "0600",
				content => template("mv_ssh/authorized_keys.erb"),
				require => File["/home/${owner}/.ssh"],
			}
      
    }		
	}
	


}