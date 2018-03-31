defmodule TeacherWeb.MovieController do
  use TeacherWeb, :controller

  alias Teacher.Features
  alias Teacher.Features.Movie

  def index(conn, params) do
    movies = Features.list_movies(params)
    render(conn, "index.html", movies: movies)
  end

  def new(conn, _params) do
    changeset = Features.change_movie(%Movie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movie" => movie_params}) do
    case Features.create_movie(movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: movie_path(conn, :show, movie))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    movie = Features.get_movie!(id)
    render(conn, "show.html", movie: movie)
  end

  def edit(conn, %{"id" => id}) do
    movie = Features.get_movie!(id)
    changeset = Features.change_movie(movie)
    render(conn, "edit.html", movie: movie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Features.get_movie!(id)

    case Features.update_movie(movie, movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie updated successfully.")
        |> redirect(to: movie_path(conn, :show, movie))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", movie: movie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Features.get_movie!(id)
    {:ok, _movie} = Features.delete_movie(movie)

    conn
    |> put_flash(:info, "Movie deleted successfully.")
    |> redirect(to: movie_path(conn, :index))
  end
end
