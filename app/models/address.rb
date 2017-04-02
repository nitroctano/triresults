class Address
  attr_accessor :city, :state, :location

  #Initializes instance variables
  def initialize(city=nil, state=nil, loc=nil)
    @city=city
    @state=state
    @location=loc
  end

  #creates a DB-form of the instance
  def mongoize
    {:city=>@city, :state=>@state, :loc=>@location.mongoize}
  end

  #takes in all forms of the object and produces a DB-friendly form
  def self.mongoize(object)
    case object
    when nil then nil
    when Address then object.mongoize
    when Hash then
      Address.new(object[:city],object[:state],Point.mongoize(object[:loc])).mongoize
    else object
    end
  end

  #creates an instance of the class from the DB-form of the data
  def self.demongoize(object)
    case object
    when nil then nil
    when Address then object
    when Hash then
      if object[:loc].nil? then
        Address.new(object[:city],object[:state],object[:loc])
      else
        Address.new(object[:city],object[:state],Point.new(object[:loc][:coordinates][0],object[:loc][:coordinates][1]))
      end
    end
  end

  #used by criteria to convert object to DB-friendly form
  def self.evolve(object)
    case object
    when nil then nil
    when Address then object.mongoize
    else object
    end
  end

end
