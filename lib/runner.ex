defmodule AOC2022.Runner do
  alias AOC2022.Puzzle, as: Puzzle
  alias AOC2022.P6, as: P6

  defp print_latest_solution do
    puzzle_info = P6.get_puzzle_info()
    solution = Puzzle.solve(P6)

    unless solution[:part_one] == nil do
      IO.puts("Part one (#{puzzle_info.part_one_mode}) answer: #{solution[:part_one]}")
    end

    unless solution[:part_two] == nil do
      IO.puts("Part two (#{puzzle_info.part_two_mode}) answer: #{solution[:part_two]}")
    end
  end

  def main(_args), do: print_latest_solution()
end
