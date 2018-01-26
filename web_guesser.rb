require 'sinatra'
require 'sinatra/reloader'

get '/' do
  game = Game.new()
  guess = params[:guess].to_i
  cheat = params[:cheat]? true : false
  game.check_guess(guess) if guess.between?(1,100)
  game.decrease_live(guess) if guess.between?(1,100)
  erb :index, :locals => {:message => game.message, :background_color => game.color, :lives => Game.lives(), :cheat => cheat, :number => Game.secret_number }
end

class Game
  attr_accessor :message, :color
  @message
  @color
  @@lives = 5
  @@secret_number = rand(100)
  def initialize
    @message = "Guess the secret number between 0 and 100!"
    @color = "white"
  end

  def self.lives
    @@lives
  end

  def self.secret_number
    @@secret_number
  end

  def check_guess(guess)
    if (guess > @@secret_number)
      @message = (guess - @@secret_number) > 5 ? "Way too High!": "Too High!"
      @color = (guess - @@secret_number) > 5 ? "red": "LightCoral"
    elsif (guess < @@secret_number)
      @message = (@@secret_number - guess) > 5 ? "Way too Low!": "Too Low!"
      @color = (@@secret_number - guess) > 5 ? "red": "LightCoral"
    else
      @message = "Correct! <br></br> The secret number is #{@@secret_number}!"
      @color = "Lime"
    end
  end
  def decrease_live(guess)
    @@lives -= 1 unless @@secret_number == guess
    if (@@lives < 1)
      @message = "YOU LOST! <br></br> The Secret Number was #{@@secret_number}! <br></br> Guess again to start a new game."
      @@secret_number = rand(100)
      @color = "white"
      @@lives = 5
    end
  end
end
