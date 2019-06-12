Spree::Admin::ProductsController.class_eval do
  before_action :set_vendor_id, only: [:create, :update]
  before_action :load_vendors, only: [:new, :edit]

  def stock
    @variants = @product.variants.includes(*variant_stock_includes)
    @variants = [@product.master] if @variants.empty?
    @stock_locations = Spree::StockLocation.accessible_by(current_ability, :read)
    if @stock_locations.empty?
      flash[:error] = Spree.t(:stock_management_requires_a_stock_location)
      redirect_to admin_stock_locations_path
    end
  end

  private

  def load_vendors
    @vendors = Spree::Vendor.order(Arel.sql('LOWER(name)'))
  end
end
