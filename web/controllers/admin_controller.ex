defmodule Test.AdminController do
  use Test.Web, :controller

  alias Test.Admin

  plug :scrub_params, "admin" when action in [:create, :update]

  def index(conn, _params) do
    admins = Repo.all(Admin)
    render(conn, "index.json", admins: admins)
  end

  def create(conn, %{"admin" => admin_params}) do
    changeset = Admin.changeset(%Admin{}, admin_params)

    case Repo.insert(changeset) do
      {:ok, admin} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", admin_path(conn, :show, admin))
        |> render("show.json", admin: admin)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Test.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    admin = Repo.get!(Admin, id)
    render(conn, "show.json", admin: admin)
  end

  def update(conn, %{"id" => id, "admin" => admin_params}) do
    admin = Repo.get!(Admin, id)
    changeset = Admin.changeset(admin, admin_params)

    case Repo.update(changeset) do
      {:ok, admin} ->
        render(conn, "show.json", admin: admin)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Test.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin = Repo.get!(Admin, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(admin)

    send_resp(conn, :no_content, "")
  end
end
