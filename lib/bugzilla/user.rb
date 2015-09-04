# user.rb
# Copyright (C) 2010-2014 Red Hat, Inc.
#
# Authors:
#   Akira TAGOH  <tagoh@redhat.com>
#
# This library is free software: you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'yaml'
require 'bugzilla/api_tmpl'

module Bugzilla

=begin rdoc

=== Bugzilla::User

Bugzilla::User class is to access the
Bugzilla::WebService::User API that allows you to create
User Accounts and log in/out using an existing account.

=end

  class User < APITemplate

=begin rdoc

==== Bugzilla::User#session(user, password)

Keeps the bugzilla session during doing something in the block.

=end

    def session(user, password)
      r = check_version('4.4.3')
      key = :cookie
      if r[0] then
        # Usisng tokens
        key = :token
        fname = File.join(ENV['HOME'], '.ruby-bugzilla-token.yml')
      else
        fname = File.join(ENV['HOME'], '.ruby-bugzilla-cookie.yml')
      end
      host = @iface.instance_variable_get(:@xmlrpc).instance_variable_get(:@host)
      val = nil

      if File.exist?(fname) && File.lstat(fname).mode & 0600 == 0600 then
        conf = YAML.load(File.open(fname).read)
        val = conf[host]
      else
        conf = {}
      end
      if !val.nil? then
        if key == :token then
          print "Using token\n"
          @iface.token = val
        else
          print "Using cookie\n"
          @iface.cookie = val
        end
        yield
      elsif user.nil? || password.nil? then
        yield
        return
      else
        login({'login'=>user, 'password'=>password, 'remember'=>true})
        yield
      end
      if key == :token then
        conf[host] = @iface.token
      else
        conf[host] = @iface.cookie
      end
      File.open(fname, 'w') {|f| f.chmod(0600); f.write(conf.to_yaml)}

      return key
    end # def session

=begin rdoc

==== Bugzilla::User#get_userinfo(params)

=end

    def get_userinfo(user)
      p = {}
      ids = []
      names = []

      if user.kind_of?(Array) then
        user.each do |u|
          names << u if u.kind_of?(String)
          id << u if u.kind_of?(Integer)
        end
      elsif user.kind_of?(String) then
	names << user
      elsif user.kind_of?(Integer) then
	ids << user
      else
        raise ArgumentError, sprintf("Unknown type of arguments: %s", user.class)
      end

      result = get({'ids'=>ids, 'names'=>names})

      result['users']
    end # def get_userinfo

=begin rdoc

==== Bugzilla::User#login(params)

Raw Bugzilla API to log into Bugzilla.

See http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/User.html

=end

=begin rdoc

==== Bugzilla::User#logout

Raw Bugzilla API to log out the user.

See http://www.bugzilla.org/docs/tip/en/html/api/Bugzilla/WebService/User.html

=end

    protected

    def _login(cmd, *args)
      raise ArgumentError, "Invalid parameters" unless args[0].kind_of?(Hash)

      res = @iface.call(cmd,args[0])
      unless res['token'].nil? then
        @iface.token = res['token']
      end

      return res
    end # def _login

    def _logout(cmd, *args)
      @iface.call(cmd)
    end # def _logout

    def __offer_account_by_email(cmd, *args)
      # FIXME
    end # def _offer_account_by_email

    def __create(cmd, *args)
      # FIXME
    end # def _create

    def __update(cmd, *args)
      # FIXME
    end # def _update

    def _get(cmd, *args)
      raise ArgumentError, "Invalid parameters" unless args[0].kind_of?(Hash)

      requires_version(cmd, 3.4)
      res = @iface.call(cmd, args[0])
      # FIXME
    end # def _get

  end # class User

end # module Bugzilla
