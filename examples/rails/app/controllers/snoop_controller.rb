class SnoopController < ApplicationController
  def index
    @snoop = {}
    @snoop[:env]               = request.env
    @snoop[:remote_addr]       = request.remote_addr
    @snoop[:remote_ip]         = request.remote_ip
    @snoop[:host_with_port]    = request.host_with_port
    @snoop[:path]              = request.path
    @snoop[:relative_url_root] = request.relative_url_root
    @snoop[:server_software]   = request.server_software
    @snoop[:cookies]           = request.cookies
    @snoop[:session_options]   = request.session_options
    @snoop[:session]           = request.session.inspect
    @snoop[:load_path]         = $LOAD_PATH
  end

  def hello
    forward_to "/hello?from+SnoopController"
  end

  def session_form
    sess = session
    def sess.data; @data; end
    @session_hash = sess.data
  end
  
  def session_edit
    if request.post?
      session[params[:key]] = params[:value] if params[:key]
    end
    redirect_to :action => "session_form"
  end
end