class Athlete
  attr_accessor :name, :test, :summaries
  
  def initialize(athlete, test, summaries)
    @name = athlete
    @test = test
    @summaries = summaries
  end
end
