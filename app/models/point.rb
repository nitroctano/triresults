class Point
  attr_accessor :longitude, :latitude

  #Initializes instance variables
  def initialize(lng, lat)
    @longitude=lng
    @latitude=lat
  end

  #creates a DB-form of the instance
  def mongoize
    {:type=>'Point', :coordinates=>[@longitude,@latitude]}
  end

  #takes in all forms of the object and produces a DB-friendly form
  def self.mongoize(object)
    case object
    when nil then nil
    when Point then object.mongoize
    when Hash then
      if object[:type] #in GeoJSON Point format
        Point.new(object[:coordinates][0],object[:coordinates][1]).mongoize
      else #in legacy format
        Point.new(object[:lng], object[:lat]).mongoize
      end
    end
  end

  #creates an instance of the class from the DB-form of the data
  def self.demongoize(object)
    case object
    when nil then nil
    when Point then object
    when Hash then
      Point.new(object[:coordinates][0],object[:coordinates][1])
    end
  end

  #used by criteria to convert object to DB-friendly form
  def self.evolve(object)
    case object
    when Point then object.mongoize
    else object
    end
  end

end
