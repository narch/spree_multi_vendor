module SpreeMultiVendor
  module Api
    module V1
      module StockItemsControllerDecorator
        private

        def scope
          includes = { variant: [{ option_values: :option_type }, :product] }
          @stock_location.stock_items.accessible_by(current_ability, :read).includes(includes)
        end
      end
    end
  end
end

Spree::Api::V1::StockItemsController.prepend SpreeMultiVendor::Api::V1::StockItemsControllerDecorator
