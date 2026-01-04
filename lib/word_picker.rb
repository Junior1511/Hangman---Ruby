class WordPicker
  def initialize
    @word = nil
  end

  def pick_word
    File.open("../1000_words.txt","r") do |file| 
      words_array = file.read.split(" ")
      words_array.select! do |word|
        word.length >= 5 && word.length <= 12 
      end
      words_array.sample
    end
  end
end

dude = WordPicker.new
dude.pick_word