defmodule Hangman.StudentComputer do
  import Hangman.Dictionary

  alias Hangman.Game

  def play do
    game = Game.new_game
    length = Game.word_length(game)
    # IO.puts "Dude, the word is '#{game.word}' and it's length is #{length} \n"
    alphabets = words_of_length(length)
    #Grab the frequencies of each letter from the words of same length.
    #That way we have more probability of getting hits.
    |> get_letters
    |> List.flatten
    #Routine to get freq. of each letter from: https://www.rosettacode.org/wiki/Letter_frequency#Elixir
    |> Enum.filter(fn c -> c =~ ~r/[a-z]/ end)
    |> Enum.reduce(Map.new, fn c,acc -> Map.update(acc, c, 1, &(&1+1)) end)
    |> Enum.sort_by(fn {_k,v} -> -v end)
    #citaion ends
    |> tuple_to_list
    |> List.flatten
    guessing_point(game, game.att_left, nil, alphabets)
  end

  def guessing_point(game, _num, :won, _remaining__list), do: IO.puts "\nI won, you puny humans. The word was '#{game.word}'"
  def guessing_point(game, 0, :lost, _remaining__list), do: IO.puts "I lost. The word was '#{game.word}'"
  def guessing_point(game, attempts, status, alphabets) when attempts != 0 do
    IO.puts Game.word_as_string(game)
    guessing_point_handler(game, alphabets)
  end

  #========== HELPERS =============

  defp guessing_point_handler(game, alphabets) do
    {popped_elem, remaining__list} = process_alphabets(alphabets)
    {game, status, guess} = Game.make_move(game, popped_elem)
    give_verdict(status, guess, game.att_left)
    guessing_point(game, game.att_left, status, remaining__list)
  end

  def process_alphabets(alphabets), do: {List.first(alphabets), List.delete_at(alphabets, 0)}

  defp give_verdict(:won, guess, _lives), do: IO.puts "\nThe guess '#{guess}' was final guess."
  defp give_verdict(:lost, guess, lives), do: IO.puts "\nThe guess '#{guess}' was final guess. Lives left #{lives}"
  defp give_verdict(:bad_guess, guess, lives), do: IO.puts "\nThe guess '#{guess}' was bad. Lives left #{lives}"
  defp give_verdict(:good_guess, guess, lives), do: IO.puts "\nSweet! The guess '#{guess}' was correct!\nYou still have #{lives} lives left!"

  def get_letters([head|tail]) do
    [String.codepoints(head)|get_letters(tail)]
  end
  def get_letters([]), do: []

  def tuple_to_list([head|tail]) do
    [Tuple.to_list(Tuple.delete_at(head, 1))|tuple_to_list(tail)]
  end
  def tuple_to_list([]), do: []

  #====== TEST AREA ========
  # alphabets = [
  #   "s","e","a","r","o","i",
  #   "l","t","n","u","d","c",
  #   "y","p","m","h","g","b",
  #   "k","f","w","v","z","x",
  #   "j","q"
  # ]


end
