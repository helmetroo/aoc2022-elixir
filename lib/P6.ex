defmodule AOC2022.P6 do
  alias AOC2022.Puzzle, as: Puzzle

  def get_puzzle_info do
    %Puzzle{
      number: 6,
      part_one_mode: :full,
      part_two_mode: :full
    }
  end

  @sizes %{
    :packet_start => 4,
    :message => 14
  }

  def parse_input_file(buffer), do: String.trim(buffer)

  def first_marker_position(buffer, size_type) do
    required_size = @sizes[size_type]
    buffer_chrs = String.graphemes(buffer)
    first_marker_position_from(buffer_chrs, 0, required_size)
  end

  def first_marker_position_from(buffer_chrs, index, required_size) do
    differing_char_set =
      Enum.reduce_while(buffer_chrs, MapSet.new(), fn chr, set ->
        done =
          MapSet.member?(set, chr) or
            MapSet.size(set) == required_size

        if done do
          {:halt, set}
        else
          {:cont, MapSet.put(set, chr)}
        end
      end)

    differing_size = MapSet.size(differing_char_set)

    if differing_size == required_size do
      index + required_size
    else
      [_ | rest_chrs] = buffer_chrs
      first_marker_position_from(rest_chrs, index + 1, required_size)
    end
  end

  def solve_part_one(buffer) do
    first_marker_position(buffer, :packet_start)
  end

  def solve_part_two(buffer) do
    first_marker_position(buffer, :message)
  end
end
