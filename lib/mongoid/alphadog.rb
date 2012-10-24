module Mongoid
  module Alphadog
    extend ActiveSupport::Concern

    module ClassMethods
      
      def alphabetize_on(*fields)
        return false unless fields.present?
        fields.map(&:to_s).each { |f|
          symbol = "#{f}_loweralpha".to_sym
          field(symbol, type: String)
          index({symbol => 1})
          meth = "set_#{f}_loweralpha".to_sym
          class_eval <<-RUBY
            before_save do
              self.send("#{symbol}=".to_sym, self.send(f.to_sym).try(:downcase))
            end
          RUBY
        }
        
        instance_eval do
         scope :alphabetized_by, lambda { |*alpha_fields|
            aorder = alpha_fields.map do |alpha|
              [[alpha.to_s, 'loweralpha'].join('_').to_sym, :asc]
            end
            order_by(aorder)
          }
        end
      end
      
    end
    
  end
end
