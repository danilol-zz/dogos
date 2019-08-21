module Page.NotFound exposing (view)

import Asset
import Css
    exposing
        ( backgroundColor
        , hex
        , marginBottom
        , px
        , width
        )
import Html.Styled exposing (Html, a, div, h1, img, main_, text)
import Html.Styled.Attributes exposing (css, src)
import Route
import Styles
    exposing
        ( container
        , heroContainer
        , resetStyles
        , textCenter
        )



-- VIEW


viewLogo : Html msg
viewLogo =
    div [ css [ textCenter, marginBottom (px 75) ] ]
        [ a [ Route.href Route.Home ]
            [ img [ css [ width (px 300) ], Asset.src Asset.logo ] []
            ]
        ]


view : { title : String, content : Html msg }
view =
    { title = "Page Not Found"
    , content =
        main_ [ css [ resetStyles, backgroundColor (hex "f6cad9") ] ]
            [ div
                [ css
                    [ container
                    , heroContainer
                    ]
                ]
                [ div []
                    [ viewLogo
                    , h1 [ css [ textCenter ] ] [ text "Page not found!" ]
                    , div [ css [ textCenter ] ] [ img [ Asset.src Asset.shit ] [] ]
                    ]
                , div [] [ img [] [] ]
                ]
            ]
    }
