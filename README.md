# Mastermind

A command line version of the [Mastermind board game](https://en.wikipedia.org/wiki/Mastermind_(board_game) "Mastermind")

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add mastermind to your list of dependencies in `mix.exs`:

        def deps do
          [{:mastermind, "~> 0.0.1"}]
        end

  2. Ensure mastermind is started before your application:

        def application do
          [applications: [:mastermind]]
        end
