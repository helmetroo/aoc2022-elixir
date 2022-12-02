defmodule AOC2022.MixProject do
  alias AOC2022.Runner, as: Runner

  use Mix.Project

  def project do
    [
      app: :aoc2022_elixir,
      version: "0.0.0",
      elixir: "~> 1.12",
      escript: [main_module: Runner],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6"},
      {:dogma, "~> 0.1.16"}
    ]
  end
end
