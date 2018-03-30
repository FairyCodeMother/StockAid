class BinsController < ApplicationController
  require_permission :can_view_bins?
  require_permission :can_edit_bins?, except: [:index]
  active_tab "inventory"

  def index
    @bins = Bin.includes(:bin_location, :items).all.to_a
  end

  def new
  end

  def create
    current_user.create_bin(params)
    redirect_to bins_path, flash: { success: "Bin created!" }
  end
end
