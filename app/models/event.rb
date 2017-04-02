class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  validates :order, :name, presence: true
  embedded_in :parent, polymorphic: true, touch: true

  def meters
    if (distance.nil? or units.nil?) == false
      case units
      when 'kilometers'
        distance*1000
      when 'yards'
        distance*0.9144
      when 'miles'
        distance*1609.344
      when 'meters'
        distance
      else
        nil
      end
    end
  end

  def miles
    if (distance.nil? or units.nil?) == false
      case units
      when 'meters'
        distance*0.000621371
      when 'kilometers'
        distance*0.621371
      when 'yards'
        distance*0.000568182
      when 'miles'
        distance
      else nil
      end
    end
  end

end
