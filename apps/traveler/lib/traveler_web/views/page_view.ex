defmodule TravelerWeb.PageView do
  use TravelerWeb, :view

  alias Traveler.SpaceObjects

  def space_objects, do: SpaceObjects.get_all_objects()
end
