require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    return @letters
  end

  def english_word
    url = "https://dictionary.lewagon.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end

  # The method returns true if the block never returns false or nil
  def letter_in_grid
    @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each_char { |letter| print letter, ''}
    if !letter_in_grid
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{grid_letters}."
    elsif !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_grid && !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    else letter_in_grid && !english_word
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end

end
