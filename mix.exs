defmodule ExampleValidation.MixProject do
  use Mix.Project

  def project do
    [
      app: :example_validation,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.7"},
      {:dataspecs, git: "https://github.com/visciang/dataspecs.git", tag: "2.0.0"}
    ]
  end
end
