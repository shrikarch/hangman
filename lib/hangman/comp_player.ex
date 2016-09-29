defmodule Comp do
  import Hangman.Dictionary

  alias Hangman.Game

  def play do
    game = Game.new_game
    length = Game.word_length(game)
    IO.puts "Dude, the word is '#{game.word}' and it's length is #{length} \n"
    #get_words(length)
    guessing_point(game)
  end

  def guessing_point(game) do
    Game.word_as_string(game)
    {game, status, guess} = Game.make_move(game, random)
    #unless(game.att_left == 0) do
    game
    #guessing_point(game, game.att_left)
  end
  # def guessing_point(game, attempts) when attempts == 0 do
  #   "break"
  # end

  def random do
    Enum.random([
      "a","b","c","d","e","f",
      "g","h","i","j","k","l",
      "m","n","o","p","q","r",
      "s","t","u","v","w","x",
      "y","z"
    ])
  end

  def get_words(length) do
    words_of_length(length)
  end
end
