defmodule AOC2022.P6 do
  alias AOC2022.Puzzle, as: Puzzle

  def get_puzzle_info do
    %Puzzle{
      number: 6,
      part_one_mode: :full
    }
  end

  def parse_input_file(buffer), do: String.trim(buffer)

  # "Differings" = "differing characters". This method name is already too long.
  def first_marker_of_four_differings(buffer) do
    buffer_chrs = String.graphemes(buffer)
    initial_state = {0, MapSet.new()}

    {marker, _} =
      Enum.reduce_while(buffer_chrs, initial_state, fn chr, {marker, set} ->
        updated_set =
          if MapSet.member?(set, chr) do
            new_set = MapSet.new()
            MapSet.put(new_set, chr)
          else
            MapSet.put(set, chr)
          end

        if MapSet.size(set) == 4 do
          {:halt, {marker, set}}
        else
          next_state = {marker + 1, updated_set}
          {:cont, next_state}
        end
      end)

    marker
  end

  def solve_part_one(buffer) do
    first_marker_of_four_differings(buffer)
  end

  def solve_part_two(buffer) do
  end
end
