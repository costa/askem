# Go to http://wiki.merbivore.com/pages/init-rb

use_orm :datamapper
use_test :rspec
use_template_engine :haml

dependency "merb-helpers"
dependency "do_sqlite3"
dependency "dm-aggregates"
# IMPORTANT
# export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib:$DYLD_FALLBACK_LIBRARY_PATH
# or an equivalent on your OS if you're not on OSX yet
dependency "gd2"

Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end

Merb::BootLoader.after_app_loads do
  GD2::Font::TrueType.fontconfig = true # TODO use local fonts in future!
end

class Merb::Request  # to make routing possible
  def ref; params[:ref]; end
end

Merb::Router.prepare do
  match('/:question', :method => :get, :ssim => true).
    to(:controller => 'askem', :action => 'ssim_reply')
  match('/:question', :method => :get).
    to(:controller => 'askem', :action => 'show').
    name('show')
  match('/', :method => :get).
    to(:controller => 'askem', :action => 'index').
    name('index')
end

Merb::Config.use { |c|
  c[:environment]         = 'production',
  c[:framework]           = {},
  c[:log_level]           = :debug,
  c[:log_stream]          = STDOUT,
  # or use file for logging:
  # c[:log_file]          = Merb.root / "log" / "merb.log",
  c[:use_mutex]           = false,
  c[:session_store]       = 'cookie',
  c[:session_id_key]      = '_askem_session_id',
  c[:session_secret_key]  = 'b6ce5cd5ec56a95a64f3af99b7e4acd61faa9cac',
  c[:exception_details]   = true,
  c[:reload_classes]      = true,
  c[:reload_templates]    = true,
  c[:reload_time]         = 0.5
}

Merb.add_mime_type(:png,  :to_png,  %w[image/png]) # TODO move it out?
