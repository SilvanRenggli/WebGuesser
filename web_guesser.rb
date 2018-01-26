require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

get '/' do
  game = Game.new()
  guess = params[:guess].to_i
  game.check_guess(guess) if guess.between?(1,100)
  game.decrease_live(guess) if guess.between?(1,100)
  erb :index, :locals => {:message => game.message, :background_color => game.color, :lives => Game.lives() }
end

class Game
  attr_accessor :message, :color
  @message
  @color
  @@lives = 5
  def initialize
    @message = "Guess the secret number between 0 and 100!"
    @color = "white"
  end

  def self.lives
    @@lives
  end

  def check_guess(guess)
    if (guess > SECRET_NUMBER)
      @message = (guess - SECRET_NUMBER) > 5 ? "Way too High!": "Too High!"
      @color = (guess - SECRET_NUMBER) > 5 ? "red": "LightCoral"
    elsif (guess < SECRET_NUMBER)
      @message = (SECRET_NUMBER - guess) > 5 ? "Way too Low!": "Too Low!"
      @color = (SECRET_NUMBER - guess) > 5 ? "red": "LightCoral"
    else
      @message = "Correct! <br></br> The secret number is #{SECRET_NUMBER}!"
      @color = "Lime"
    end
  end
  def decrease_live(guess)
    @@lives -= 1 unless SECRET_NUMBER == guess
    if (@@lives < 1)
      @message = "YOU LOST! <br></br> The Secret Number was #{SECRET_NUMBER}! <br></br> Guess again to start a new game."
      @color = "white"
      @@lives = 5
    end
  end
end
