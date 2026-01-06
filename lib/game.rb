

class Game
  require_relative "board"
  require_relative "word_picker"
  require "json"

  def initialize
    @board = Board.new
    @word_picker = WordPicker.new
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
      File.open("game_object.txt", "w") do |file|
        file.puts(game_object.to_json)
      end

    end
  end

  def turns
    until @board.turns_left == 0 || @board.correct_array.include?("_") == false
      save_game
      @board.correct_letters("_", (@word_picker.word.length - 1))
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
