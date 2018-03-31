defmodule Teacher.Features.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teacher.Features.Movie
  import Ecto.Query, only: [from: 2]

  schema "movies" do
    field :genre, :string
    field :summary, :string
    field :title, :string
    field :year, :string

    timestamps()
  end

  @doc false
  def changeset(%Movie{} = movie, attrs) do
    movie
    |> cast(attrs, [:title, :summary, :year, :genre])
    |> validate_required([:title, :summary, :year, :genre])
  end

  def search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from movie in query,
    where: ilike(movie.title, ^wildcard_search),
    or_where: ilike(movie.summary, ^wildcard_search)
  end

end
