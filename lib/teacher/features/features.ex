defmodule Teacher.Features do
  @moduledoc """
  The Features context.
  """

  import Ecto.Query, warn: false
  alias Teacher.Repo

  alias Teacher.Features.Movie

  def list_movies(params) do
    search_term = get_in(params, ["query"])

    Movie
    |> Movie.search(search_term)
    |> Repo.all()
  end

end
