module Page.Components.Header exposing (view)

import Asset
import Css
    exposing
        ( alignSelf
        , center
        )
import Html.Styled
    exposing
        ( Html
        , a
        , div
        , img
        )
import Html.Styled.Attributes exposing (css)
import Route
import Styles
    exposing
        ( container
        , logo
        )


viewLogo : Html msg
viewLogo =
    div [ css [ alignSelf center ] ]
        [ a [ Route.href Route.Home ]
            [ img [ Asset.src Asset.logo, css [ logo ] ] []
            ]
        ]


view : Html msg
view =
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
