#! /usr/bin/env elixir

Mix.install([:ecto_sql])

defmodule ApiDataStructure do
  defmodule Address do
    use Ecto.Schema
    import Ecto.Changeset

    @required_fields [:streetname, :streenumber, :postcode, :town]

    @primary_key false
    embedded_schema do
      field(:streetname, :string)
      field(:streenumber, :string)
      field(:postcode, :string)
      field(:town, :string)
    end

    def changeset(profile, attrs) do
      profile
      |> cast(attrs, [:streetname, :streenumber, :postcode, :town])
      |> validate_required(@required_fields)
    end
  end

  defmodule Profile do
    use Ecto.Schema
    import Ecto.Changeset

    @required_fields [:timezone]

    @primary_key false
    embedded_schema do
      field(:timezone, :string)
    end

    def changeset(profile, attrs) do
      profile
      |> cast(attrs, [:timezone])
      |> validate_required(@required_fields)
    end
  end

  defmodule User do
    use Ecto.Schema
    import Ecto.Changeset

    alias ApiDataStructure.Profile

    @required_fields [:username, :email]

    @primary_key false
    embedded_schema do
      field(:username, :string)
      field(:email, :string)
      embeds_many(:address, Address)
      embeds_one(:profile, Profile)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, [:username, :email])
      |> cast_embed(:profile, with: &Profile.changeset/2, required: true)
      |> cast_embed(:address, with: &Address.changeset/2, required: true)
      |> validate_required(@required_fields)
    end
  end

  def run do
    input = %{
      "username" => "xxx",
      "email" => "xxx@mail.com",
      "profile" => %{"timezone" => "Europe/Prague"},
      "address" => [
        %{
          "streetname" => "High Street",
          "streenumber" => "3a",
          "postcode" => "SO31 4NG",
          "town" => "Hedge End, Southampton"
        }
      ]
    }

    %ApiDataStructure.User{}
    |> ApiDataStructure.User.changeset(input)
    |> Ecto.Changeset.apply_changes()
  end
end

ApiDataStructure.run()
|> IO.inspect()

# %ApiDataStructure.User{
#   address: [
#     %ApiDataStructure.Address{
#       postcode: "SO31 4NG",
#       streenumber: "3a",
#       streetname: "High Street",
#       town: "Hedge End, Southampton"
#     }
#   ],
#   email: "xxx@mail.com",
#   profile: %ApiDataStructure.Profile{timezone: "Europe/Prague"},
#   username: "user"
# }
