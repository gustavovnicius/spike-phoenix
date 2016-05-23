defmodule Test.AdminView do
  use Test.Web, :view

  def render("index.json", %{admins: admins}) do
    %{data: render_many(admins, Test.AdminView, "admin.json")}
  end

  def render("show.json", %{admin: admin}) do
    %{data: render_one(admin, Test.AdminView, "admin.json")}
  end

  def render("admin.json", %{admin: admin}) do
    %{id: admin.id,
      name: admin.name,
      age: admin.age}
  end
end
