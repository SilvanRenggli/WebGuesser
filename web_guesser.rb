require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

get '/' do
  game = Game.new()
  guess = params[:guess].to_i
  game.check_guess(guess)
  erb :index, :locals => {:message => game.message, :background_color => game.color}
end

class Game
  attr_accessor :message, :color
  @message
  @color
  def initialize

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
end
