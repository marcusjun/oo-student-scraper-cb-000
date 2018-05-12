class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)

    student_hash.each {|key,value| self.send(key.to_s+"=",value)}

    #Code below does the same thing
    #student_hash.each do |key,value|
      ##self.send(key,value)
      #self.send(key.to_s+"=",value)
    #end

    @@all << self

    ##########################################################################
    #Wish I could do this...
    #@@all << student_hash.collect {|key,value| self.send(key.to_s+"=",value)}

  end

  def self.create_from_collection(students_array)
    students_array.each {|student| self.new(student)}

    #Code below does the same thing
    #students_array.each do |student|
      #Either code works
      #Student.new(student)
      #self.new(student)
    #end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key,value| self.send(key.to_s+"=",value)}
    self

    #Code below does the same thing
    #attributes_hash.each do |key,value|
      #self.send(key.to_s+"=",value)
    #end
    #self
  end

  def self.all
    @@all
  end
end
