defmodule Traveler.Repo.Migrations.AddInitialObjects do
  use Ecto.Migration

  alias Traveler.Repo
  alias Traveler.SpaceObject

  def change do
    Repo.insert(%SpaceObject{object_name: "Earth", gravity: 9.807})
    Repo.insert(%SpaceObject{object_name: "Moon", gravity: 1.62})
    Repo.insert(%SpaceObject{object_name: "Mars", gravity: 3.711})
  end
end
