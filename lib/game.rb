

class Game
  require_relative "board"
  require_relative "word_picker"
  require "json"

  def initialize
    @board = Board.new
    @word_picker = WordPicker.new
    load_game
  end

  def load_game
    puts "Would you like to load a previous game?"
    puts "Please type Y or N"
    answer = gets.chomp.downcase
    if answer == "y"
      object_file = File.read("game_object.json")
      game_object = JSON.parse(object_file)
      @word_picker.word = game_object["word"]
      @board.incorrect_array = game_object["incorrect_words"]
      @board.correct_array = game_object["correct_words"]
      @board.turns_left = game_object["turns_left"]
    end
  end

  def save_game
    puts "Would you like to save the game?"
    puts "Please type Y or N"
    answer = gets.chomp.downcase
    if answer == "y"
      game_object = {
        :word => @word_picker.word,
        :incorrect_words => @board.incorrect_array,
        :correct_words => @board.correct_array,
        :turns_left => @board.turns_left
      }
      File.write("game_object.json", game_object.to_json)
      exit
    end
  end

  def turns
    if @correct_array == ["_"]
      @board.correct_letters("_", (@word_picker.word.length - 1))
    end
    until @board.turns_left == 0 || @board.correct_array.include?("_") == false
      if @board.turns_left <= 7
        save_game
      end
      @board.print_board
      puts "Type a letter"
      user_input = gets.chomp.downcase
      unless user_input.length == 1
        puts "You typed more than one letter"
        puts "Please type ONE letter"
        user_input = gets.chomp.downcase
      end
      if @word_picker.word.split("").include?(user_input) == true
        @word_picker.word.split("").each_with_index do |letter_in_array, index|
          if letter_in_array == user_input
            @board.correct_letters(user_input, index)
            @board.print_board
          end
        end
      else
        @board.incorrect_letters(user_input)
        @board.take_turn
        @board.print_board
      end
    end
  end

  def define_winner
    if @board.correct_array.include?("_")
      puts "You lose, the word was #{@word_picker.word}"
    else
      puts "You win, Good job!"
    end
  end

  def start_game
    turns
    define_winner
  end
end
