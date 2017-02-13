require 'longest_word.rb'

class LongestController < ApplicationController
  def game
    @grid_size = 10
    @grid = generate_grid(@grid_size)
  end

  def score
    @grid = params[:grid]
    @attempt = params[:attempt]
    @start = params[:start].to_i
    @end = Time.now.to_i
    @answer = run_game(@attempt, @grid, @start, @end)
  end
end
