 require 'open-uri'
 require 'json'


 def generate_grid(grid_size)
  # TODO: generate random grid of letters
  (0...grid_size).map { ('A'..'Z').to_a[rand(26)] }
end

def check_english(attempt)
  words = File.read('/usr/share/dict/words').upcase.split("\n")
  words.any? { |word| attempt.upcase == word.upcase }
end

def get_translation(attempt)
  api_key = "95206b36-bb09-43fc-9532-71993ba8d3a7"
  att = attempt.downcase
  url = "https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=#{api_key}&input=#{att}"
  translation = open(url).read
  word_database = JSON.parse(translation)
  return word_database["outputs"][0]["output"]
end

def check_grid(attempt, grid)
  attempt_array = attempt.upcase.split("")
  attempt_array.all? { |x| attempt_array.count(x) <= grid.count(x) }
end

def run_game(attempt, grid, start_time, end_time)
  # TODO: runs the game and return detailed hash of result

  if check_grid(attempt, grid)
    if check_english(attempt)
      result = {
        time: end_time - start_time,
        translation: get_translation(attempt),
        score: attempt.length - (end_time - start_time),
        message: "well done"
      }
    else
      result = {
        time: end_time - start_time,
        translation: nil,
        score: 0,
        message: "not an english word"
      }
    end
  else
    result = {
      time: end_time - start_time,
      translation: get_translation(attempt),
      score: 0,
      message: "not in the grid"
    }
  end
end
