defmodule Rev do
  import Hangman.Dictionary
  def print do
    random_word()

  end

  def auto do
    alias Hangman.Game, as: G
    #game = %{word: G.new_game}
    #len = G.word_length(game)
  end

end
