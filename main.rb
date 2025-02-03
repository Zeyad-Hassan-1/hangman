require_relative 'lib/serialization'
require_relative 'lib/check_for_saved'

lines = File.readlines("words.txt");
fail_number_of_attempts = 0


def generateRand(lines)
  return rand(0..(lines.length-1))
end

def checkAlpha(alpha,selected_word)
  if !(selected_word.include?alpha)
    puts "FAIL GUESS"
    return false
  end
end

while lines[generateRand(lines)].length < 5
end

selected_word = lines[generateRand(lines)].chomp
guess_word = Array.new(selected_word.length,'-')
total_number_of_attempts = (selected_word.length) * 2 


if Progress.start() == 'l'
  loaded_game = BasicSerializable.load_from_file("game.json", Hangman.new("","",0))
  selected_word = loaded_game.selected
  guess_word = loaded_game.guessed
  total_number_of_attempts = loaded_game.attempts
  puts guess_word.join(' ')
end

while total_number_of_attempts > 0

  puts "Guess the Alphapitical of the word"
  puts "Enter the alpha you feel that true:"
  alpha = gets.chomp

  checkAlpha(alpha,selected_word)
  total_number_of_attempts -=1
  puts "rest number of attempts you have is #{total_number_of_attempts}"
  print "The secret key: "

  selected_word.chars.each_with_index do |e,i|
    if(alpha == e)
      guess_word[i] = e
    end
  end
  print guess_word.join(' ')
  if Progress.check_winning(guess_word)
    puts "You Win!"
    break
  else
  end
  puts "If you want to save your progress and continue later (+ then enter) if not press enter"
  key = gets.chomp
  if key == '+'
    game = Hangman.new(selected_word,guess_word,total_number_of_attempts)
    serialize_text = game.serialize
    game.save_to_file("game.json",serialize_text)
    exit(1)
  end
end

if fail_number_of_attempts == total_number_of_attempts
  puts "You Lose"
end