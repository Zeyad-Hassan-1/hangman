require 'json'

module BasicSerializable
  @@serializer = JSON #change JSON to what you want
  

def serialize
    obj = {}
    instance_variables.map do |var|
		obj[var] = instance_variable_get(var)
	end
    @@serializer.dump obj
end
  

  def unserialize(string)
    obj = @@serializer.parse(string)
    obj.keys.each do |key|
	    instance_variable_set(key, obj[key])
    end
  end

  # Save the serialized object to a file
  def save_to_file(filename,serialize_text)
    File.open(filename, 'w') do |file|
      file.write(serialize_text) # Write the serialized string to the file
    end
    puts "Object saved to #{filename}"
  end
  
  # Load an object from a file
  def self.load_from_file(filename, target_object)
    data = File.read(filename) # Read the serialized string from the file
    target_object.unserialize(data) # Deserialize the string into the target object
    puts "Object loaded from #{filename}"
    target_object
  end

end


class Hangman
  include BasicSerializable
    attr_accessor :selected, :guessed, :attempts
    def initialize(selected, guessed, attempts)
      @selected = selected
      @guessed = guessed
      @attempts = attempts
    end
end