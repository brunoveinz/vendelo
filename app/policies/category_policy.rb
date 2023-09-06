class CategoryPolicy < BasePolicy

    def method_missing(name, *args, &block)
        Current.user.admin?
    end
end