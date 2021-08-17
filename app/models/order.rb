class Order < ApplicationRecord

    attr_writer :current_step 
    # attr_accessor :shipping_name, :billing_name

    validates_presence_of :shipping_name, :if => lambda { |o| o.current_step == "shipping" }
    validates_presence_of :billing_name, :if => lambda { |o| o.current_step == "billing" }


    def current_step 
        @current_step || steps.first
    end

    def steps 
        %w[shipping billing confirmation]
    end

    def next_step 
        self.current_step = steps[steps.index(current_step)+1]
    end

    def previous_step
        self.current_step = steps[steps.index(current_step)-1]
    end

    def first_step? 
        current_step == steps.first
    end

    def last_step? 
        current_step == steps.last
    end
end
