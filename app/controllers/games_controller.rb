class GamesController < ApplicationController

  def new
    grid = ("A".."Z").to_a
    @letters = 10.times.map { (grid[rand(grid.length)]) }
  end

  def score
    @input = params[:input]
    @letters = params[:letters]
    @included = right_letters?(@input, @letters)
    @english_word = english_word?(@input)
  end

  def right_letters?(attempt, letters)
    attempt = attempt.split("")
    attempt.all? { |letter| @letters.include?(letter) && attempt.count(letter) <= @letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    json["found"]
  end
end
