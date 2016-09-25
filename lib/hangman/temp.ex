defmodule Rev do
  import Hangman.Dictionary

#Declaring the required variables

  def print do
    random_word()
  end

  blanks = def lines(str) do
    String.replace(str, ~r/./, "_")
    |> String.split("")
    |> Enum.join(" ")
    |> String.trim_trailing
  end

  def to_list(str, guess, blanks) do
    String.codepoints(str)
    |> find_indexes(guess)
    |> replace_lines(guess, blanks)
  end

  def auto do
    alias Hangman.Game, as: G
    #game = %{word: G.new_game}
    #len = G.word_length(game)
  end


  def present([h|t], h),  do: true
  def present([h|t], val) do
    false
    present(t, val)
  end
  #def present([], val), do: nil

  def index(str, k) do
    Enum.find_index(str, fn(x) -> x==k  end)
  end

  def mapy([list], c) do
    Enum.map(list, fn (x) when x==c -> true
    end)
  end

  #def count([h|t], s) when s==h do: true

  def reg(str) do
    Regex.replace ~r/#{str}/, "caterpillar", "*"
  end

  def find_indexes(list, var) do
  # From - http://stackoverflow.com/questions/18551814/find-indexes-from-list-in-elixir
    indexes = Enum.with_index(list) |> Enum.filter_map(fn {x, _} -> x == var end, fn {_, i} -> i end)
  # citation end
  end

  def replace_lines(indexes, guess, blanks) do
    updated_blanks = Enum.reduce(indexes, blanks, fn(index, acc_str) ->
        String.split(acc_str, " ") |> List.replace_at(index, guess) |> Enum.join(" ")
      end)
  end

end
