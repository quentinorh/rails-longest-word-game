require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    letters = (1..10).to_a
    @letters = letters.map do |letter|
      letter = alphabet.sample
    end
  end

  def score
    answer = params[:answer].chars
    letters = params[:letters].split
    if !grid(answer, letters)
      @message = "The word can’t be built out of the original grid"
    else
      if dico(params[:answer])
         @message = "The word is valid according to the grid and is an English word"
      else
        @message = "The word is valid according to the grid and is an English word"
      end
    end
  end

  def dico(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    dico_serialized = URI.open(url).read
    @dico = JSON.parse(dico_serialized)
    return @dico['found'] ? true : false
  end

  def grid(answer, letters)
    answer.each do |letter|
      if letters.include?(letter)
        letters.delete_at(letters.index(letter))
      else
        return false
      end
      return true
    end
  end
end
