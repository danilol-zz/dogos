module Page.Dog exposing
    ( Model
    , Msg
    , Problem(..)
    , Status(..)
    , init
    , toSession
    , update
    , view
    )

{-| The dog page. You can get here via the /dog route.
This is an example page. You can make this dog be anything you need!
-}

import Api exposing (decodeError)
import Asset
import Breed
import Css
    exposing
        ( alignSelf
        , center
        , color
        , fontWeight
        , hex
        , int
        , listStyle
        , margin
        , marginBottom
        , marginTop
        , none
        , padding
        , pct
        , px
        , width
        , zero
        )
import Dog exposing (DogMetadata)
import Html.Styled as Styled
    exposing
        ( Html
        , a
        , div
        , h1
        , h2
        , img
        , li
        , tbody
        , td
        , text
        , tr
        , ul
        )
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Http
import Route
import Session exposing (Session)
import Styles
    exposing
        ( container
        , logo
        , resetStyles
        , shadow
        , tableStriped
        , textCenter
        )
import Task
import Time
import Utils.Html exposing (select)



-- MODEL


type alias Model =
    { title : String
    , session : Session
    , problems : List Problem
    , searchedBreed : String
    , timeZone : Time.Zone
    , breeds : List String

    -- Loaded independently from server
    , dog : Status DogMetadata
    }


type Problem
    = ServerError String


type Status a
    = Loading
    | Loaded a
    | Failed
    | Succeeded


init : Session -> Maybe String -> ( Model, Cmd Msg )
init session urlBreed =
    let
        ( status, searchCmd, searchedBreed ) =
            case urlBreed of
                Nothing ->
                    ( Loading
                    , Http.send CompletedRandomSearch randomSearch
                    , "random"
                    )

                Just breed ->
                    ( Loading
                    , Http.send CompletedSearch (search breed)
                    , breed
                    )
    in
    ( { title = "Dog Search"
      , session = session
      , problems = []
      , searchedBreed = searchedBreed
      , timeZone = Time.utc
      , dog = status
      , breeds = Breed.breedsList
      }
    , Cmd.batch
        [ Task.perform GotTimeZone Time.here
        , searchCmd
        ]
    )



-- VIEW


view :
    { model
        | title : String
        , dog : Status DogMetadata
        , searchedBreed : String
        , problems : List Problem
        , timeZone : Time.Zone
        , breeds : List String
    }
    -> { title : String, content : Html Msg }
view model =
    { title = model.title
    , content =
        case model.dog of
            Loaded dog ->
                div [ css [ resetStyles ] ]
                    [ viewHeader
                    , div
                        [ css [ container, marginTop (px 50), width (pct 50) ] ]
                        [ div [ css [ shadow ] ]
                            [ div [ css [ Styles.dataHeader ] ] [ h1 [ css [ margin zero ] ] [ text "Dog Search" ] ]
                            , h2
                                [ css [ margin zero, Styles.dataSubHeader ] ]
                                [ text ("Searched Breed: " ++ model.searchedBreed)
                                ]
                            , Styled.table [ css [ Styles.table, tableStriped ] ]
                                [ tbody []
                                    [ tr []
                                        [ td []
                                            [ text "Picture" ]
                                        , td []
                                            [ img
                                                [ Asset.src (Asset.dynamicImage dog.message)
                                                , css [ width (px 300) ]
                                                ]
                                                []
                                            ]
                                        ]
                                    , tr []
                                        [ td [] [ text "Select random or breed you like!" ]
                                        , td []
                                            [ selectBreed model.searchedBreed
                                            , Styled.button
                                                [ css
                                                    [ Styles.button
                                                    , Styles.buttonSearch
                                                    ]
                                                , onClick GetBreed
                                                ]
                                                [ text "Bring me another dogo" ]
                                            ]
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]

            Loading ->
                div [ css [ resetStyles ] ]
                    [ viewHeader
                    , div [ css [ container, textCenter, marginTop (px 50) ] ]
                        [ h2 [ css [ margin zero, marginBottom (px 60), color (hex "4fa756"), fontWeight (int 400) ] ]
                            [ text "Loading!!" ]
                        , img [ Asset.src Asset.loading, css [ width (px 300) ] ] []
                        ]
                    ]

            Succeeded ->
                div [ css [ resetStyles ] ]
                    [ viewHeader
                    , div [ css [ container, textCenter, marginTop (px 50) ] ]
                        [ h2
                            [ css
                                [ margin zero
                                , marginBottom (px 60)
                                , color (hex "4fa756")
                                , fontWeight (int 400)
                                ]
                            ]
                            [ text "Success!!" ]
                        , img [ Asset.src Asset.unicorn, css [ width (px 300) ] ] []
                        ]
                    ]

            Failed ->
                div
                    [ css [ resetStyles ] ]
                    [ viewHeader
                    , viewProblems model
                    ]
    }



-- SEARCH view


selectBreed : String -> Html Msg
selectBreed searchedBreed =
    Styled.map
        GotSelectBreed
        (select (Breed.breedOptions searchedBreed))


viewLogo : Html msg
viewLogo =
    div [ css [ alignSelf center ] ]
        [ a [ Route.href Route.Home ]
            [ img [ Asset.src Asset.logo, css [ logo ] ] []
            ]
        ]



-- HEADER VIEW


viewHeader : Html Msg
viewHeader =
    div [ css [ Styles.header ] ]
        [ div
            [ css
                [ container
                , Css.property "display" <| "grid"
                , Css.property "grid-template-columns" <| " 170px 1fr"
                ]
            ]
            [ viewLogo
            ]
        ]


viewProblems : { model | problems : List Problem } -> Html msg
viewProblems model =
    div
        [ css
            [ container
            , textCenter
            , marginTop (px 50)
            ]
        ]
        [ ul
            [ css
                [ margin zero
                , padding zero
                , listStyle none
                ]
            ]
            (List.map viewProblem model.problems)
        , img [ Asset.src Asset.error, css [ width (px 300) ] ] []
        ]


viewProblem : Problem -> Html msg
viewProblem problem =
    let
        errorMessage =
            case problem of
                ServerError str ->
                    str
    in
    li []
        [ h2
            [ css
                [ margin zero
                , marginBottom (px 60)
                , color (hex "4fa756")
                , fontWeight (int 400)
                ]
            ]
            [ text errorMessage
            ]
        ]



-- UPDATE


type Msg
    = CompletedSearch (Result Http.Error DogMetadata)
    | CompletedRandomSearch (Result Http.Error DogMetadata)
    | GotTimeZone Time.Zone
    | GotSelectBreed String
    | GetBreed


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CompletedSearch (Ok dog) ->
            ( { model
                | dog = Loaded dog
              }
            , Cmd.none
            )

        CompletedSearch (Err error) ->
            let
                serverErrors =
                    [ ServerError (decodeError error) ]
            in
            ( { model | dog = Failed, problems = serverErrors }, Cmd.none )

        GotTimeZone tz ->
            ( { model | timeZone = tz }, Cmd.none )

        GotSelectBreed breed ->
            ( { model
                | searchedBreed = breed
              }
            , Cmd.none
            )

        CompletedRandomSearch (Ok dog) ->
            ( { model
                | dog = Loaded dog
              }
            , Cmd.none
            )

        CompletedRandomSearch (Err error) ->
            let
                serverErrors =
                    [ ServerError (decodeError error) ]
            in
            ( { model
                | dog = Failed
                , problems = serverErrors
              }
            , Cmd.none
            )

        GetBreed ->
            let
                cmd =
                    if model.searchedBreed == "random" then
                        Http.send CompletedRandomSearch randomSearch

                    else
                        Http.send CompletedSearch (search model.searchedBreed)
            in
            ( model, cmd )



-- SUBSCRIPTIONS
-- EXPORT


toSession : Model -> Session
toSession model =
    model.session



-- HTTP


search : String -> Http.Request DogMetadata
search searchedBreed =
    Dog.byBreed searchedBreed


randomSearch : Http.Request DogMetadata
randomSearch =
    Dog.random
