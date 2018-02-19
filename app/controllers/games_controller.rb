require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    session[:user_score] = 0 unless session[:user_score]
    generate_letters(10)
    @score = session[:user_score]
  end

  def score
    @result = check_win_status(params[:word], params[:letters].split(' '))
    @score = session[:user_score]
    # raise
  end

  private

  def generate_letters(num_letters)
    selector = Random.new
    alphabet = ("a".."z").to_a
    @letters = []
    num_letters.times{@letters << alphabet[selector.rand(26)]}
    return @letters
  end

  def check_win_status(word, letters)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    api_ping = open(url).read
    word_in_dic = JSON.parse(api_ping)

    word.split('').each do |letter|
      if letters.index(letter)
        letters.delete_at(letters.index(letter))
      else
        return "Sorry but #{word.upcase} can't be built out of #{letters.join(',').upcase}"
      end
    end

    if word_in_dic['found']
      session[:user_score] += word.length
      return "Congratulations! #{word.upcase} is a valid English word"
    else
      return "Sorry but #{word.upcase} does not seem to be a valid English word..."
    end
  end
end
