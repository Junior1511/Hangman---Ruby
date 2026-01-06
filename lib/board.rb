require 'io/console'

class Board
  attr_accessor :turns_left, :correct_array, :incorrect_array

  def initialize
    @turns_left = 8
    @incorrect_array = []
    @correct_array = ["_"]
  end

  def print_board
    width = IO.console.winsize[1]
    board = [
      "     ",
      "You have #{@turns_left} turns left",
      "Incorrect Letters : #{@incorrect_array}",
      "Correct Letters : #{@correct_array}"
    ]
    board.map! { |line| line.center(width) }
    puts board
  end

  def take_turn
    @turns_left -= 1
  end

  def incorrect_letters(letter)
    @incorrect_array << letter
    @incorrect_array.uniq!
  end

  def correct_letters(letter, position)
    @correct_array[position] = letter.to_s
    @correct_array.map! { |word| word.nil? ? "_" : word}
  end
end
