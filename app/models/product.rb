class Product < ApplicationRecord
    include PgSearch::Model
    include Favoritable

    ORDER_BY = {
        newest: "created_at DESC",
        expensives: "price DESC",
        cheapest: "price ASC"
    }

    pg_search_scope :search_full_text, against: {
        title: 'A',
        description: 'B'
    }

    
    has_one_attached :foto

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    belongs_to :category
    belongs_to :user, default: -> {Current.user}


    def owner? 
        user_id == Current.user&.id
    end

    def broadcast
        broadcast_replace_to self, partial: 'products/product_details', locals: { product: self}
    end

end
