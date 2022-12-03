defmodule AOC2022.P3 do
  alias AOC2022.Puzzle, as: Puzzle

  def get_puzzle_info do
    %Puzzle{
      number: 3,
      part_one_mode: :full,
      part_two_mode: :full
    }
  end

  def parse_input_file(buffer) do
    buffer
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  def solve_part_one(backpacks) do
    Enum.reduce(backpacks, 0, fn backpack, acc ->
      acc + (get_common_char(backpack) |> get_priority())
    end)
  end

  def solve_part_two(backpacks) do
    backpacks
    |> Enum.chunk_every(3)
    |> Enum.reduce(0, fn group, acc ->
      group_priority =
        group
        |> Enum.map(&MapSet.new/1)
        |> intersect_all()
        |> MapSet.to_list()
        |> hd
        |> get_priority()

      acc + group_priority
    end)
  end

  def get_common_char(backpack) do
    midpoint = round(length(backpack) / 2)
    {first_compart, second_compart} = Enum.split(backpack, midpoint)

    first_compart_uniques = MapSet.new(first_compart)
    second_compart_uniques = MapSet.new(second_compart)

    # Assumes one and only one common match!
    MapSet.intersection(first_compart_uniques, second_compart_uniques)
    |> MapSet.to_list()
    |> hd
  end

  def intersect_all(sets) do
    [first | rest] = sets
    Enum.reduce(rest, first, fn set, acc -> MapSet.intersection(set, acc) end)
  end

  def get_priority(chr) do
    # \p{Lu} is the Unicode character property regex escape sequence matching any uppercase letter
    uppercase = <<chr>> =~ ~r/^\p{Lu}$/u
    offset = if uppercase, do: 38, else: 96
    chr - offset
  end
end
