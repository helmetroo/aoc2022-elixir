defmodule AOC2022.P1 do
  alias AOC2022.Puzzle, as: Puzzle

  def get_puzzle_info do
    %Puzzle{
      number: 1,
      part_one_mode: :full,
      part_two_mode: :full
    }
  end

  def parse_input_file(buffer) do
    buffer
    |> String.split("\n")
    |> Enum.chunk_by(&(&1 != ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(fn elf -> Enum.map(elf, &String.to_integer/1) end)
  end

  defp sort_by_total_calories(calories) do
    Enum.map(calories, &Enum.sum/1)
    |> Enum.sort(:desc)
  end

  def solve_part_one(calories) do
    sort_by_total_calories(calories)
    |> hd
  end

  def solve_part_two(calories) do
    sort_by_total_calories(calories)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
