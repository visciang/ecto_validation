defmodule ExampleValidationTest do
  use ExUnit.Case

  @data %{
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

  test "dataspecs" do
    alias ExampleValidation.DataSpecs.ApiDataStructure.{Address, Profile, User}

    expected_data = %User{
      address: [
        %Address{
          postcode: "SO31 4NG",
          streenumber: "3a",
          streetname: "High Street",
          town: "Hedge End, Southampton"
        }
      ],
      email: "xxx@mail.com",
      profile: %Profile{
        timezone: "Europe/Prague"
      },
      username: "xxx"
    }

    assert {:ok, expected_data} == DataSpecs.load(@data, {User, :t})
  end

  test "ecto" do
    alias ExampleValidation.Ecto.ApiDataStructure.{Address, Profile, User}

    expected_data = %User{
      address: [
        %Address{
          postcode: "SO31 4NG",
          streenumber: "3a",
          streetname: "High Street",
          town: "Hedge End, Southampton"
        }
      ],
      email: "xxx@mail.com",
      profile: %Profile{
        timezone: "Europe/Prague"
      },
      username: "xxx"
    }

    assert expected_data == %User{} |> User.changeset(@data) |> Ecto.Changeset.apply_changes()
  end
end
