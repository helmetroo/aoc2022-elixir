defmodule AOC2022.P5 do
  alias AOC2022.Puzzle, as: Puzzle

  def get_puzzle_info do
    %Puzzle{
      number: 5,
      part_one_mode: :full,
      part_two_mode: :full
    }
  end

  defmodule StackState do
    def new(str) do
      [_ | stacks] =
        str
        |> String.split("\n")
        |> Enum.reverse()

      Enum.reduce(stacks, %{}, &add_boxes/2)
    end

    def add_boxes(line, state) do
      Map.merge(
        state,
        add_level(line),
        fn _col, cur_boxes, [next_box] ->
          [next_box | cur_boxes]
        end
      )
    end

    def add_level(line) do
      add_level_from(line, 1, %{})
    end

    # Beginning or middle
    def add_level_from(<<head::binary-size(3), " ", rest::binary>>, index, map),
      do: add_matching_box(head, rest, index, map)

    # End of string case where there is no skip character (space)
    def add_level_from(<<head::binary-size(3)>>, index, map),
      do: add_matching_box(head, "", index, map)

    def add_level_from(_, _, map), do: map

    def add_matching_box(head, rest, index, map) do
      new_map =
        case Regex.run(~r/[\p{Lu}]/u, head) do
          nil -> map
          box -> Map.put(map, index, box)
        end

      add_level_from(rest, index + 1, new_map)
    end

    def execute(stack_state, instructions, mode \\ :at_a_time) do
      Enum.reduce(instructions, stack_state, fn inst, state ->
        {taken_boxes, boxes_left} = Enum.split(state[inst.from], inst.count)

        # Reversing the boxes we took is analogous to taking them one at a time
        boxes_to_place = if mode == :at_a_time, do: Enum.reverse(taken_boxes), else: taken_boxes

        state
        |> Map.replace(inst.from, boxes_left)
        |> Map.replace(inst.to, boxes_to_place ++ state[inst.to])
      end)
    end

    def get_message(stack_state) do
      Enum.reduce(1..map_size(stack_state), "", fn col, message ->
        message <> hd(stack_state[col])
      end)
    end
  end

  defmodule Instruction do
    @enforce_keys [:count, :from, :to]
    defstruct count: 0, from: 0, to: 0

    def new_from_list(str) do
      str
      |> String.split("\n", trim: true)
      |> Enum.map(&new/1)
    end

    def new(line) do
      [_, count_str, from_str, to_str] = Regex.run(~r/move (\d+) from (\d+) to (\d+)/, line)

      %Instruction{
        :count => String.to_integer(count_str),
        :from => String.to_integer(from_str),
        :to => String.to_integer(to_str)
      }
    end
  end

  def parse_input_file(buffer) do
    [initial_stacks_str, instructions_str] = String.split(buffer, "\n\n")

    {
      StackState.new(initial_stacks_str),
      Instruction.new_from_list(instructions_str)
    }
  end

  def solve_part_one({stack_state, instructions}) do
    StackState.execute(stack_state, instructions, :at_a_time)
    |> StackState.get_message()
  end

  def solve_part_two({stack_state, instructions}) do
    StackState.execute(stack_state, instructions, :all_at_once)
    |> StackState.get_message()
  end
end
