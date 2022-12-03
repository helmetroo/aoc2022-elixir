defmodule AOC2022.Runner do
  alias AOC2022.Puzzle, as: Puzzle
  alias AOC2022.P3, as: P3

  defp print_latest_solution do
    solution = Puzzle.solve(P3.get_puzzle_info(), P3)

    unless solution[:part_one] == nil do
      IO.puts("Part one answer: #{solution[:part_one]}")
    end

    unless solution[:part_two] == nil do
      IO.puts("Part two answer: #{solution[:part_two]}")
    end
  end

  def main(_args), do: print_latest_solution()
end
