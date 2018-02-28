module Bugzilla
  module Utils
    def get_proxy(info)
      uri = info[:Proxy] || ENV['http_proxy']
      proxy_uri = uri.nil? ? nil : URI.parse(uri)
      proxy_host = proxy_uri.nil? ? nil : proxy_uri.host
      proxy_port = proxy_uri.nil? ? nil : proxy_uri.port
      [proxy_host, proxy_port]
    end

    def get_xmlrpc(conf = {}, opts = {})
      info = conf
      uri = URI.parse(info[:URL])
      host = uri.host
      port = uri.port
      path = uri.path.empty? ? nil : uri.path
      proxy_host, proxy_port = get_proxy(info)
      timeout = opts[:timeout].nil? ? 60 : opts[:timeout]
      yield host if block_given? # if you want to run some pre hook
      xmlrpc = XMLRPC.new(host, port:port, path: path, proxy_host:
                                    proxy_host, proxy_port: proxy_port, timeout:
                                    timeout, http_basic_auth_user: uri.user,
                                    http_basic_auth_pass: uri.password, debug: opts[:debug])
      [xmlrpc, host]
    end
  end
end
