defmodule AOC2022.P1 do
  alias AOC2022.Puzzle, as: Puzzle

  def get_puzzle_info do
    %Puzzle{
      number: 1,
      part_one_mode: :full
    }
  end

  def parse_input_file(buffer) do
    buffer
    |> String.split("\n")
    |> Enum.chunk_by(&(&1 != ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(fn elf -> Enum.map(elf, &String.to_integer/1) end)
  end

  def solve_part_one(calories) do
    [most | _] =
      Enum.map(calories, &Enum.sum/1)
      |> Enum.sort(:desc)

    most
  end

  def solve_part_two(input) do
    2
  end
end
