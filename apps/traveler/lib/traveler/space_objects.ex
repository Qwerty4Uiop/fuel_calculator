defmodule Traveler.SpaceObjects do
  alias Traveler.Repo
  alias Traveler.SpaceObject

  def get_all_objects do
    Repo.all(SpaceObject)
  end

  def find_by_name(name), do: Repo.get_by(SpaceObject, object_name: name)

  @spec create_or_update(map) :: {:ok, SpaceObject.t()} | {:error, Ecto.Changeset.t()}
  def create_or_update(attrs) do
    case find_by_name(attrs.object_name) do
      nil -> %SpaceObject{}
      space_object -> space_object
    end
    |> create_or_update(attrs)
  end

  @spec create_or_update(SpaceObject.t(), map) :: {:ok, SpaceObject.t()} | {:error, Ecto.Changeset.t()}
  def create_or_update(space_object, attrs) do
    space_object
    |> SpaceObject.changeset(attrs)
    |> Repo.insert_or_update()
  end
end
