defmodule Test.AdminControllerTest do
  use Test.ConnCase

  alias Test.Admin
  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    admin = Repo.insert! %Admin{}
    conn = get conn, admin_path(conn, :show, admin)
    assert json_response(conn, 200)["data"] == %{"id" => admin.id,
      "name" => admin.name,
      "age" => admin.age}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, admin_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, admin_path(conn, :create), admin: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Admin, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_path(conn, :create), admin: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    admin = Repo.insert! %Admin{}
    conn = put conn, admin_path(conn, :update, admin), admin: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Admin, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    admin = Repo.insert! %Admin{}
    conn = put conn, admin_path(conn, :update, admin), admin: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    admin = Repo.insert! %Admin{}
    conn = delete conn, admin_path(conn, :delete, admin)
    assert response(conn, 204)
    refute Repo.get(Admin, admin.id)
  end
end
