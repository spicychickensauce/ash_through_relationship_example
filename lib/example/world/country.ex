defmodule Example.World.Country do
  # use Ash.Resource, otp_app: :example, domain: Example.World, data_layer: AshPostgres.DataLayer
  use Ash.Resource, otp_app: :example, domain: Example.World, data_layer: AshSqlite.DataLayer

  # postgres do
  #   table "countries"
  #   repo Example.Repo
  # end
  sqlite do
    table "countries"
    repo Example.Repo
  end

  code_interface do
    define :read
    define :create
  end

  actions do
    defaults [:read, :create]
    default_accept [:name]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :name, :string, allow_nil?: false
  end

  relationships do
    has_many :regions, Example.World.Region

    has_many :cities, Example.World.City do
      no_attributes? true
      filter expr(region.country_id == parent(id))
    end

    has_many :landmarks, Example.World.Landmark do
      no_attributes? true

      # "fetch landmarks that have their city's region's `country_id` field
      #  matching my `id` field"
      filter expr(city.region.country_id == parent(id))

      # an alternative implementation:
      # "fetch landmarks that have a `city_id` value in the list of my related
      #  cities' `id` values"
      # filter expr(city_id in parent(cities.id))
    end
  end

  # aggregates do
  #   count :city_count, :cities
  #   count :landmark_count, :landmarks
  # end

  identities do
    identity :name, [:name]
  end
end
