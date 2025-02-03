require_relative 'serialization'

module Progress
  def self.start
    if File.exist?("game.json")
      puts "If you want to load your progress Enter (l then enter)"
      key = gets.chomp
      return key
    end
  end

  def self.check_winning(guessed)
    guessed.each do |i|
      if i == '-'
        return false
      end
    end
    return true
  end
end
