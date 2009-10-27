import "common"
import "baselines/*.pp"
import "modules/*.pp"
import "infrastructures/*.pp"
import "roles/*.pp"
import "nodes.pp"

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

# Package { provider => "yum" }

# Centralized backup filebucket
filebucket { main: server => puppet }
filebucket { local: path => "/var/lib/puppet/clientbucket" }
filebucket { server: server => puppet, port=> 8140 }

