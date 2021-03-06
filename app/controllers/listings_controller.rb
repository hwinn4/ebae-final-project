class ListingsController < ApplicationController

  def new
    @listing = Listing.new
    item = @listing.build_item
    @pictures = []
    5.times do 
      @pictures << item.pictures.build
    end
    # item.pictures.build
  end

  def create
    listing = Listing.new(listing_params.except(:item))
    if listing.duration #need to work on proper validation for all fields
      listing.starting_price = (listing_params[:starting_price].to_f * 100).to_i
      listing.shipping_price = (listing_params[:shipping_price].to_f * 100).to_i
      listing.end_time = listing.start_time + listing.duration.days
      listing.seller = current_user.seller
      listing.save
      redirect_to listing_path(listing)
    else
      redirect_to new_listing_path
    end
  end

  def index
    # @listings = Listing.all
    @listings = Listing.active.sort_by(&:end_time)
  end

  def show
    @listing = Listing.find(params[:id])
    @past_bids = @listing.bids.sort_by(&:created_at).reverse
    @bid = Bid.new
    RecentlyViewedListing.find_or_create_by(listing_id: @listing.id, user_id: current_user.id)
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def listing_params
    params.require(:listing).permit(:starting_price, :shipping_price, :start_time, :duration, :item_attributes => [:name, :description, :picture_url, :condition_id, :category_id, :pictures_attributes => [:image]])
  end

end
