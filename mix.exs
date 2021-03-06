defmodule BingoHall.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bingo_hall,
      version: "0.0.1",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BingoHall.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:bingo, path: "./bingo"}

      # {:bingo, "~> 1.0"}
      # {:bingo, git: "https://github.com/username/bingo.git"}
      # {:bingo, git: "git@github.com:username/bingo.git"}
      # {:bingo, in_umbrella: true}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "cmd npm install --prefix assets"],
      build: [
        "cmd DOCKER_BUILDKIT=1 docker build --secret id=_secret,src=.secret --secret id=_db_url,src=.db_url -t bb ."
      ],
      run: ["cmd docker run -p 4000:4000 bb"]
    ]
  end
end
