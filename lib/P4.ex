defmodule AOC2022.P4 do
  alias AOC2022.Puzzle, as: Puzzle

  def get_puzzle_info do
    %Puzzle{
      number: 4,
      part_one_mode: :full,
      part_two_mode: :full
    }
  end

  defmodule RangePair do
    @enforce_keys [:first, :second]
    defstruct first: 0..0, second: 0..0

    def get_larger_and_smaller(%RangePair{first: first, second: second}) do
      first_size = Range.size(first)
      second_size = Range.size(second)

      if first_size >= second_size do
        {first, second}
      else
        {second, first}
      end
    end

    def contains_other?(%RangePair{} = pair) do
      {larger, smaller} = get_larger_and_smaller(pair)

      smaller.first >= larger.first &&
        smaller.last <= larger.last
    end

    def overlaps_other?(%RangePair{first: first, second: second}) do
      !Range.disjoint?(first, second)
    end
  end

  def parse_input_file(buffer) do
    buffer
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_range_pair/1)
  end

  def parse_range_pair(range_pair_str) do
    range_pair_pattern = ~r/(?<p1_s>\d*)-(?<p1_e>\d*),(?<p2_s>\d*)-(?<p2_e>\d*)/

    %{
      "p1_s" => p1_start,
      "p1_e" => p1_end,
      "p2_s" => p2_start,
      "p2_e" => p2_end
    } = Regex.named_captures(range_pair_pattern, range_pair_str)

    pair_one = String.to_integer(p1_start)..String.to_integer(p1_end)
    pair_two = String.to_integer(p2_start)..String.to_integer(p2_end)
    %RangePair{first: pair_one, second: pair_two}
  end

  def solve_part_one(range_pairs) do
    Enum.reduce(range_pairs, 0, fn pair, acc ->
      if RangePair.contains_other?(pair), do: acc + 1, else: acc
    end)
  end

  def solve_part_two(range_pairs) do
    Enum.reduce(range_pairs, 0, fn pair, acc ->
      if RangePair.overlaps_other?(pair), do: acc + 1, else: acc
    end)
  end
end
