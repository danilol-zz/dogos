module Api exposing
    ( application
    , decodeError
    , get
    , post
    , put
    )

{-| This module is responsible for communicating to the Conduit API.

It exposes an opaque Endpoint type which is guaranteed to point to the correct URL.

-}

import Api.Endpoint as Endpoint exposing (Endpoint)
import Browser
import Browser.Navigation as Nav
import Http exposing (Body)
import Json.Decode
    exposing
        ( Decoder
        , Value
        , at
        , decodeString
        , oneOf
        , string
        )
import Url exposing (Url)



-- SERIALIZATION
-- APPLICATION


application :
    { init : Url -> Nav.Key -> ( model, Cmd msg )
    , onUrlChange : Url -> msg
    , onUrlRequest : Browser.UrlRequest -> msg
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Browser.Document msg
    }
    -> Program Value model msg
application config =
    let
        init _ url navKey =
            config.init url navKey
    in
    Browser.application
        { init = init
        , onUrlChange = config.onUrlChange
        , onUrlRequest = config.onUrlRequest
        , subscriptions = config.subscriptions
        , update = config.update
        , view = config.view
        }



-- HTTP


get : Endpoint -> Decoder a -> Http.Request a
get url decoder =
    Endpoint.request
        { method = "GET"
        , url = url
        , expect = Http.expectJson decoder
        , headers = []
        , body = Http.emptyBody
        , timeout = Nothing
        , withCredentials = True
        }


put : Endpoint -> Body -> Decoder a -> Http.Request a
put url body decoder =
    Endpoint.request
        { method = "PUT"
        , url = url
        , expect = Http.expectJson decoder
        , headers = []
        , body = body
        , timeout = Nothing
        , withCredentials = False
        }


post : Endpoint -> Body -> Decoder a -> Http.Request a
post url body decoder =
    Endpoint.request
        { method = "POST"
        , url = url
        , expect = Http.expectJson decoder
        , headers = []
        , body = body
        , timeout = Nothing
        , withCredentials = False
        }



-- ERRORS


type alias ApiError =
    String


decodeError : Http.Error -> String
decodeError error =
    let
        decoderError : Decoder ApiError
        decoderError =
            oneOf
                [ at [ "EntityNotFound", "message" ] string
                , string
                ]
    in
    case error of
        Http.BadStatus response ->
            response.body
                |> decodeString decoderError
                |> Result.withDefault "Oh, something went wrong!"

        _ ->
            "Server error"
