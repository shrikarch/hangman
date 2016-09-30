defmodule Comp do
  import Hangman.Dictionary

  alias Hangman.Game

  def play do
    game = Game.new_game
    length = Game.word_length(game)
    alphabets = [
      "s","e","a","r","o","i",
      "l","t","n","u","d","c",
      "y","p","m","h","g","b",
      "k","f","w","v","z","x",
      "j","q"
    ]
    # alphabets = [
    #   "a","b","c","d","e","f",
    #   "g","h","i","j","k","l",
    #   "m","n","o","p","q","r",
    #   "s","t","u","v","w","x",
    #   "y","z"
    # ]
    IO.puts "Dude, the word is '#{game.word}' and it's length is #{length} \n"
    guessing_point(game, game.att_left, nil, alphabets)
  end

  def guessing_point(game, attempts, _status, alphabets) when attempts != 0 do
    IO.puts Game.word_as_string(game)
    guessing_point_handler(game, alphabets)
  end
  def guessing_point(game, 0, :lost, _remaining__list), do: IO.puts "I lost. The word was '#{game.word}'"
  def guessing_point(game, 0, :won, _remaining__list), do: IO.puts "\nI won, you puny humans. The word was '#{game.word}'"

  #========== HELPERS =============

  defp guessing_point_handler(game, alphabets) do
    {popped_elem, remaining__list} = process_alphabets(alphabets)
    {game, status, guess} = Game.make_move(game, popped_elem)
    give_verdict(status, guess, game.att_left)
    guessing_point(game, game.att_left, status, remaining__list)
  end

  def process_alphabets(alphabets) do
    first_alpha = List.first(alphabets)
    updated_list = List.delete_at(alphabets, 0)
    {first_alpha, updated_list}
  end

  defp give_verdict(:won, guess, _lives), do: IO.puts "\nThe guess '#{guess}' was final guess."
  defp give_verdict(:lost, guess, lives), do: IO.puts "\nThe guess '#{guess}' was final guess. Lives left #{lives}"
  defp give_verdict(:bad_guess, guess, lives), do: IO.puts "\nThe guess '#{guess}' was bad. Lives left #{lives}"
  defp give_verdict(:good_guess, guess, lives), do: IO.puts "\nSweet! The guess '#{guess}' was correct!\nYou still have #{lives} lives left!"

  def get_words(length) do
    words_of_length(length)
  end
end
