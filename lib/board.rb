require 'io/console'


class Board
  def initialize
    @turns_left = 8
    @incorrect_letters = []
    @correct_letters = []
  end

  def print_board
    width = IO.console.winsize[1]
    board = [
      "     ",
      "You have #{@turns_left} turns left",
      "Incorrect Letters : #{@incorrect_letters}",
      "Correct Letters : #{@correct_letters}"
    ]
    board.map! { |line| line.center(width) }
    puts board
  end

  def take_turn
    @turns_left -= 1
  end

  def incorrect_letters(letter)
    @incorrect_letters << letter
    @incorrect_letters.uniq!
  end

  def correct_letters(letter, position)
    @correct_letters[position] = letter.to_s
    @correct_letters.map! { |word| word.nil? ? "_" : word}
  end
end
