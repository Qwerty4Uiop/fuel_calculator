defmodule Traveler.SpaceObject do
  use Traveler.Model

  schema "space_objects" do
    field :object_name, :string
    field :gravity, :float

    timestamps()
  end

  @fields [:object_name, :gravity]
  def changeset(space_object \\ %SpaceObject{}, attrs) do
    space_object
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:object_name)
  end
end
