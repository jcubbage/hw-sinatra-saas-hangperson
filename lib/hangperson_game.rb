class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  attr_reader :valid
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @valid = false
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(l)
     if (!l.is_a? String) || !(/[a-zA-Z]/ =~ l) || (l.empty?)
      raise ArgumentError.new("Guess must be a valid letter")
    end
    l.downcase!
    if (@guesses.include? l) || (@wrong_guesses.include? l)
      @valid = false
      return false
    end
    if @word.include? l
      @guesses += l
      @valid = true
      return true
    else
      @wrong_guesses += l
      @valid = true
      return true
    end
  end 
  
  def guess_several_letters(ls)
    ls.split('').each do |l| guess(l) end
  end

end
