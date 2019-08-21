module Page.Home exposing
    ( Model
    , Msg
    , init
    , toSession
    , update
    , view
    )

{-| The homepage. You can get here via either the / or /#/ routes.
-}

import Asset
import Css
    exposing
        ( alignSelf
        , backgroundColor
        , center
        , fontSize
        , fontWeight
        , height
        , hex
        , int
        , lineHeight
        , margin
        , marginBottom
        , marginRight
        , num
        , px
        , rem
        , vh
        , width
        , zero
        )
import Html.Styled
    exposing
        ( Html
        , a
        , div
        , h1
        , h2
        , img
        , p
        , text
        )
import Html.Styled.Attributes exposing (css, href)
import Route
import Session exposing (Session)
import Styles
    exposing
        ( buttonHome
        , buttonLarge
        , container
        , heroContainer
        , resetStyles
        )



-- MODEL


type alias Model =
    { title : String
    , session : Session
    }


init : Session -> ( Model, Cmd Msg )
init session =
    ( { title = "Elm Example App", session = session }
    , Cmd.none
    )



-- VIEW


view : { model | title : String } -> { title : String, content : Html Msg }
view model =
    { title = model.title
    , content =
        div [ css [ resetStyles, backgroundColor (hex "f9ffeb") ] ]
            [ viewHero
            ]
    }


viewLogo : Html msg
viewLogo =
    div [ css [ alignSelf center, marginBottom (px 75) ] ]
        [ img [ css [ width (px 250) ], Asset.src Asset.logo ] []
        ]


viewHero : Html msg
viewHero =
    div
        [ css
            [ container
            , heroContainer
            ]
        ]
        [ div []
            [ viewLogo
            , h1 [ css [ fontSize (px 48), margin zero ] ] [ text "EEA" ]
            , h2 [] [ text "Elm Example App" ]
            , p
                [ css
                    [ fontSize (rem 1.25)
                    , lineHeight (num 1.5)
                    , fontWeight (int 200)
                    ]
                ]
                [ text "Boiler plate for an elm 0.19 app with weback loader config" ]
            , a
                [ css
                    [ Styles.button
                    , buttonLarge
                    , buttonHome
                    , marginRight (px 15)
                    ]
                , Route.href (Route.Dog Nothing)
                ]
                [ text "Dog Search" ]
            ]
        , div []
            [ img [ css [ height (vh 100) ], Asset.src Asset.elmIcon ] []
            ]
        ]



-- UPDATE


type Msg
    = GotSession Session


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotSession newSession ->
            ( { model | session = newSession }, Cmd.none )



-- EXPORT


toSession : Model -> Session
toSession model =
    model.session
