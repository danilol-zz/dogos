module Dog exposing
    ( DogMetadata
    , byBreed
    , dogDecoder
    , random
    )

{-| The interface to the Dog data structure.
This includes:

  - The Dog type itself
  - The breeds list
  - Ways to make HTTP requests to retrieve and modify customers
  - Ways to access information about a customer
  - Converting between various types

-}

import Api
import Api.Endpoint as Endpoint
import Http
import Json.Decode as Decode
    exposing
        ( Decoder
        , string
        , succeed
        )
import Json.Decode.Pipeline exposing (required)



-- TYPES


type alias DogMetadata =
    { message : String
    , status : String
    }



-- SERIALIZATION


dogDecoder : Decoder DogMetadata
dogDecoder =
    Decode.succeed DogMetadata
        |> required "message" string
        |> required "status" string



-- API


byBreed : String -> Http.Request DogMetadata
byBreed breed =
    Api.get (Endpoint.dogByBreed breed) dogDecoder


random : Http.Request DogMetadata
random =
    Api.get Endpoint.randomDog dogDecoder
