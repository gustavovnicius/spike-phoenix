defmodule Test.Repo.Migrations.CreateAdmin do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :name, :string
      add :age, :integer

      timestamps
    end

  end
end
