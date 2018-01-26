require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
get '/' do
  guess = params[:guess].to_i
  message = check_guess(guess)
  erb :index, :locals => {:message => message}
end

def check_guess(guess)
  if (guess > SECRET_NUMBER)
    message = (guess - SECRET_NUMBER) > 5 ? "Way too High!": "Too High!"
  elsif (guess < SECRET_NUMBER)
    message = (SECRET_NUMBER - guess) > 5 ? "Way too Low!": "Too Low!"
  else
    message = "Correct! <br></br> The secret number is #{SECRET_NUMBER}!"
  end
end
