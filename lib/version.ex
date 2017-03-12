defmodule PaperTrail.Version do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  schema "versions" do
    field :event, :string
    field :item_type, :string
    field :item_id, :integer
    field :item_changes, :map
    field :sourced_by,   :string
    field :meta, :map

    # belongs_to :owner

    timestamps(updated_at: false)
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:item_type, :item_id, :item_changes, :sourced_by, :meta])
    |> validate_required([:event, :item_type, :item_id, :item_changes])
  end

  def count do
    from(version in __MODULE__, select: count(version.id)) |> PaperTrail.RepoClient.repo.all
  end
end
