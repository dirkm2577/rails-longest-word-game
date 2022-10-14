require 'open-uri'

class GamesController < ApplicationController
  @letters = []
  def new
    # display a new random grid and a form
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    # receives the form input and computes and displays the result
    @word = (params[:word] || "").upcase
    # The word can’t be built out of the original grid (letter not included)
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
