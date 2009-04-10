# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4acef91c5aa1d10e8d319bc2219d548e'

  include AuthenticatedSystem

  before_filter :get_pages_for_tabs

  def get_pages_for_tabs
    if logged_in?
      @tabs = Page.find_main
    else
      @tabs = Page.find_main_public
    end
  end

  def get_page_metadata
    @page = Page.find_by_name(params[:name])
    @pagetitle = @page.title
  end

  protected
  def add_breadcrumb name, url = ''
    @breadcrumbs ||= []
    url = eval(url) if url =~ /_path|_url|@/
    @breadcrumbs << [name, url]
  end

  protected
  def set_breadcrumb_for
    # Implement in child if you want breadcrumb
    # set_breadcrumb_for page.parent if page.parent
    # add_breadcrumb page.navlabel, view_page_path(page.name)
  end

  def self.add_breadcrumb name, url, options = {}
    before_filter options do |controller|
      controller.send(:add_breadcrumb, name, url)
    end
  end

end
