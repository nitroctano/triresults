class Placing
  attr_accessor :name, :place

  #Initializes instance variables
  def initialize(name,place)
    @name=name
    @place=place
  end

  #creates a DB-form of the instance
  def mongoize
    {:name=>@name, :place=>@place}
  end

  #takes in all forms of the object and produces a DB-friendly form
  def self.mongoize(object)
    case object
    when nil then nil
    when Placing then object.mongoize
    when Hash then
      Placing.new(object[:name],object[:place]).mongoize
    else object
    end
  end

  #creates an instance of the class from the DB-form of the data
  def self.demongoize(object)
    case object
    when nil then nil
    when Hash then
      Placing.new(object[:name],object[:place])
    else object
    end
  end

  #used by criteria to convert object to DB-friendly form
  def self.evolve(object)
    case object
    when Placing then object.mongoize
    else object
    end
  end


end
