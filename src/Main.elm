module Main exposing (Msg(..), main, view)

import Api
import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (map)
import Json.Decode exposing (Value)
import Page
import Page.Blank as Blank
import Page.Dog as Dog
import Page.Home as Home
import Page.NotFound as NotFound
import Route exposing (Route)
import Session exposing (Session)
import Url exposing (Url)



-- NOTE: Based on discussions around how asset management features
-- like code splitting and lazy loading have been shaping up, it's possible
-- that most of this file may become unnecessary in a future release of Elm.
-- Avoid putting things in this module unless there is no alternative!
-- See https://discourse.elm-lang.org/t/elm-spa-in-0-19/1800/2 for more.


type Model
    = Redirect Session
    | NotFound Session
    | Home Home.Model
    | Dog Dog.Model



-- MODEL


init : Url -> Nav.Key -> ( Model, Cmd Msg )
init url navKey =
    changeRouteTo (Route.fromUrl url)
        (Redirect (Session.fromGuest navKey))



-- VIEW


view : Model -> Document Msg
view model =
    let
        viewPage page toMsg config =
            let
                { title, body } =
                    Page.view page config
            in
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        Redirect _ ->
            viewPage Page.Other (\_ -> Ignored) Blank.view

        NotFound _ ->
            viewPage Page.Other (\_ -> Ignored) NotFound.view

        Home home ->
            viewPage Page.Home GotHomeMsg (Home.view home)

        Dog dog ->
            viewPage Page.Dog GotDogMsg (Dog.view dog)



-- UPDATE


type Msg
    = Ignored
    | ChangedUrl Url
    | GotHomeMsg Home.Msg
    | GotDogMsg Dog.Msg
    | ClickedLink Browser.UrlRequest


toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            session

        NotFound session ->
            session

        Home home ->
            Home.toSession home

        Dog dog ->
            Dog.toSession dog


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just Route.Root ->
            ( model, Route.replaceUrl (Session.navKey session) Route.Home )

        Just Route.Home ->
            Home.init session
                |> updateWith Home GotHomeMsg

        Just (Route.Dog maybeEmail) ->
            Dog.init session maybeEmail
                |> updateWith Dog GotDogMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( Ignored, _ ) ->
            ( model, Cmd.none )

        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( GotHomeMsg subMsg, Home home ) ->
            Home.update subMsg home
                |> updateWith Home GotHomeMsg

        ( GotDogMsg subMsg, Dog dog ) ->
            Dog.update subMsg dog
                |> updateWith Dog GotDogMsg

        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl (Session.navKey (toSession model)) (Url.toString url)
                    )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( _, _ ) ->
            -- Disregard messages that arrived for the wrong page.
            ( model, Cmd.none )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        NotFound _ ->
            Sub.none

        Redirect _ ->
            Sub.none

        Home _ ->
            Sub.none

        Dog _ ->
            Sub.none



-- MAIN


main : Program Value Model Msg
main =
    Api.application
        { init = init
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
