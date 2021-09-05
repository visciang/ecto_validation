defmodule ExampleValidation.DataSpecs.ApiDataStructure do
  defmodule Address do
    @enforce_keys [:streetname, :streenumber, :postcode, :town]
    defstruct @enforce_keys

    @type t :: %__MODULE__{
            streetname: String.t(),
            streenumber: String.t(),
            postcode: String.t(),
            town: String.t()
          }
  end

  defmodule Profile do
    @enforce_keys [:timezone]
    defstruct @enforce_keys

    @type t :: %__MODULE__{
            timezone: String.t()
          }
  end

  defmodule User do
    @enforce_keys [:username, :email, :address, :profile]
    defstruct @enforce_keys

    @type t :: %__MODULE__{
            username: String.t(),
            email: String.t(),
            address: [Address.t()],
            profile: Profile.t()
          }
  end
end
