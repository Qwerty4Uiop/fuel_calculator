defmodule Traveler.Repo.Migrations.CreateSpaceObjects do
  use Ecto.Migration

  def change do
    create table(:space_objects, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:object_name, :string)
      add(:gravity, :float)

      timestamps()
    end

    create(unique_index(:space_objects, [:object_name]))
  end
end
