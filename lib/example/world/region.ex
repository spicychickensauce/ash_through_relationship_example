defmodule Example.World.Region do
  # use Ash.Resource, otp_app: :example, domain: Example.World, data_layer: AshPostgres.DataLayer
  use Ash.Resource, otp_app: :example, domain: Example.World, data_layer: AshSqlite.DataLayer

  # postgres do
  #   table "regions"
  #   repo Example.Repo
  # end
  sqlite do
    table "regions"
    repo Example.Repo
  end

  code_interface do
    define :read
    define :create
  end

  actions do
    defaults [:read, :create]
    default_accept [:name, :population, :country_id]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :name, :string, allow_nil?: false
    attribute :population, :integer, allow_nil?: false
  end

  relationships do
    belongs_to :country, Example.World.Country
    has_many :cities, Example.World.City
  end

  identities do
    identity :name, [:name]
  end
end
