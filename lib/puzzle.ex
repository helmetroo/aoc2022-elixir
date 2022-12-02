defmodule AOC2022.Puzzle do
  @enforce_keys [:number]
  defstruct number: 0,
            part_one_mode: :skip,
            part_two_mode: :skip

  defp load_input_file!(number, mode \\ :full) do
    input_file_name = "#{number}-#{mode}.txt"

    input_file_path =
      Path.join(File.cwd!(), "/input-files")
      |> Path.join(input_file_name)

    case File.read(input_file_path) do
      {:ok, contents} -> contents
      {:error, reason} -> throw("Can't find puzzle input file #{number}! Error: #{reason}")
    end
  end

  def solve(metadata, puzzle) do
    solution_one =
      unless metadata.part_one_mode == :skip do
        load_input_file!(metadata.number, metadata.part_one_mode)
        |> puzzle.parse_input_file()
        |> puzzle.solve_part_one()
      end

    solution_two =
      unless metadata.part_two_mode == :skip do
        load_input_file!(metadata.number, metadata.part_two_mode)
        |> puzzle.parse_input_file()
        |> puzzle.solve_part_two()
      end

    %{
      :part_one => solution_one,
      :part_two => solution_two
    }
  end
end
