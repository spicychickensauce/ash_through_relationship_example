defmodule Example.World.Landmark do
  # use Ash.Resource, otp_app: :example, domain: Example.World, data_layer: AshPostgres.DataLayer
  use Ash.Resource, otp_app: :example, domain: Example.World, data_layer: AshSqlite.DataLayer

  # postgres do
  #   table "landmarks"
  #   repo Example.Repo
  # end
  sqlite do
    table "landmarks"
    repo Example.Repo
  end

  code_interface do
    define :read
    define :create
  end

  actions do
    defaults [:read, :create]
    default_accept [:name, :city_id]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :name, :string, allow_nil?: false
  end

  relationships do
    belongs_to :city, Example.World.City
  end

  identities do
    identity :name, [:name]
  end
end
