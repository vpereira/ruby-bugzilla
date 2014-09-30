= Ruby binding for Bugzilla WebService APIs

This aims to provide similar features in Ruby to access to Bugzilla
through {WebService APIs}[http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService.html].  currently the following
APIs are available:

* Bugzilla::WebService::Bug[http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/Bug.html]
* Bugzilla::WebService::Bugzilla[http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/Bugzilla.html]
* Bugzilla::WebService::Classification[http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/Classification.html]
* Bugzilla::WebService::Product[http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/Product.html]
* Bugzilla::WebService::User[http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/User.html]


== bzconsole usage

as example, in the bin directory, we have a tool named bzconsole. with that, you can login, search and get a bug. some examples:

list all new bugs, from Novell, created after 2014-09-25, with product Security (SUSE Security Incidents):

````
bzconsole search --status=NEW --create-time=2014-09-25 --product=Security --detailed-list nvbz
````

similar for Red Hat:

````
bzconsole search --status=NEW --create-time=2014-09-28 --product=Security --detailed-list rhbz
````

search without login:

````
bzconsole search --status=NEW --anonymous --create-time=2014-09-28 --product=Security --detailed-list rhbz
````

get a specific bug:

````
bzconsole getbug nvbz:889526
````
== Copyright

Copyright (c) 2010-2014 Red Hat, Inc. See COPYING for details.

== License

This library is free software: you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation, either
version 3 of the License, or (at your option) any later version.

== Authors

Akira TAGOH
