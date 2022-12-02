defmodule AOC2022.P2 do
  alias AOC2022.Puzzle, as: Puzzle

  def get_puzzle_info do
    %Puzzle{
      number: 2,
      part_one_mode: :full,
      part_two_mode: :full
    }
  end

  defmodule Round do
    @enforce_keys [:opponent_move, :your_move]
    defstruct opponent_move: "A", your_move: "X"
  end

  def parse_input_file(buffer) do
    buffer
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&line_to_round/1)
  end

  def line_to_round(line) do
    [opponent_move, your_move] = String.split(line, " ")
    %Round{opponent_move: opponent_move, your_move: your_move}
  end

  def shape_score(round) do
    case round.your_move do
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
      _ -> raise "Invalid player shape"
    end
  end

  def outcome_score(round) do
    score_list =
      case round.your_move do
        "X" -> {3, 0, 6}
        "Y" -> {6, 3, 0}
        "Z" -> {0, 6, 3}
        _ -> raise "Invalid player shape"
      end

    index =
      case round.opponent_move do
        "A" -> 0
        "B" -> 1
        "C" -> 2
        _ -> raise "Invalid opponent shape"
      end

    elem(score_list, index)
  end

  def round_score(round), do: shape_score(round) + outcome_score(round)

  def with_chosen_move(round) do
    chosen_move =
      case round.your_move do
        "X" -> choose_losing_move(round.opponent_move)
        "Y" -> choose_draw_move(round.opponent_move)
        "Z" -> choose_winning_move(round.opponent_move)
        _ -> "Invalid round end"
      end

    %Round{round | your_move: chosen_move}
  end

  def choose_draw_move(move) do
    case move do
      "A" -> "X"
      "B" -> "Y"
      "C" -> "Z"
      _ -> raise "Invalid opponent move"
    end
  end

  def choose_losing_move(move) do
    case move do
      "A" -> "Z"
      "B" -> "X"
      "C" -> "Y"
      _ -> raise "Invalid opponent move"
    end
  end

  def choose_winning_move(move) do
    case move do
      "A" -> "Y"
      "B" -> "Z"
      "C" -> "X"
      _ -> raise "Invalid opponent move"
    end
  end

  def solve_part_one(rounds) do
    rounds
    |> Enum.reduce(0, fn round, acc -> acc + round_score(round) end)
  end

  def solve_part_two(rounds) do
    rounds
    |> Enum.reduce(0, fn round, acc ->
      updated_round_score = with_chosen_move(round) |> round_score()
      acc + updated_round_score
    end)
  end
end
