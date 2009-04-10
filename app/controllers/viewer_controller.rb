class ViewerController < ApplicationController

  def show
    @page = Page.find_by_name(params[:name])
    login_required if @page.admin?

    @subpages = @page.subpages

    set_breadcrumb_for @page
    @pagetitle = @page.title
  end
  
  def get_unformatted_text
    @page = Page.find(params[:id])
    render :text => @page.body(:source)
  end
  
  def set_page_body
    @page = Page.find(params[:id])
    @page.update_attribute(:body, params[:value])
    render :text => @page.body
  end

  protected
  def set_breadcrumb_for page
    set_breadcrumb_for page.parent if page.parent
    add_breadcrumb page.navlabel, view_page_path(page.name)
  end


end
