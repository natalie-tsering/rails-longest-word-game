require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0..rand(0..25)].join
  end

  def score
    @input = params["input"]
    @letters = params["letters"]

    if @input.include?(@letters) &&  is_it_a_word?(@input)
       @results = "Congratulations, your word can be built out of #{@letters} and it is a valid English word"
    elsif !@input.include?(@letters)
       @results = "Sorry, your word cannot be built out of #{@letters}"
    elsif !is_it_a_word?(@input)
      @results = "Sorry, #{@input} is NOT a valid English word"
    end


   # if @input.include?(@letters)
     # @results = `Congratulations, your word can be built out of #{@letters}`
    # if @input.does_not_include?(@letters)
      # @results = `Sorry, your word cannot be built out of #{@letters}`
    # if @check == true
      # @results =`Congratulations, #{@input} is a valid English word`
    # if @check == false
      #@results =`Sorry, #{@input} is NOT a valid English word`
    #if @input.include?(@letters) && @check == true
      #@results = `Congratulations, your word can be built out of #{@letters} and #{@input} is a valid English word`
    #elsif @input.does_not_include?(@letters) && @check == false
      #@results = `Sorry, your word cannot be built out of #{@letters} and #{@input} is NOT a valid English word`
  end

  def is_it_a_word?(input)
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    data_serialized = URI.open(url).read
    data = JSON.parse(data_serialized)
    @check = data["found"]
  end
end
