module Page.NotFound exposing (view)

import Asset
import Css
    exposing
        ( color
        , fontWeight
        , hex
        , int
        , margin
        , marginBottom
        , marginTop
        , px
        , zero
        )
import Html.Styled
    exposing
        ( Html
        , div
        , h2
        , img
        , text
        )
import Html.Styled.Attributes exposing (css, src)
import Page.Components.Header as Header
import Styles
    exposing
        ( container
        , resetStyles
        , textCenter
        )



-- VIEW


view : { title : String, content : Html msg }
view =
    { title = "Page Not Found"
    , content =
        div [ css [ resetStyles ] ]
            [ Header.view
            , div [ css [ container, textCenter, marginTop (px 50) ] ]
                [ h2
                    [ css
                        [ margin zero
                        , marginBottom (px 60)
                        , color (hex "4fa756")
                        , fontWeight (int 400)
                        ]
                    ]
                    [ text "Page not found!!" ]
                , div [ css [ textCenter ] ] [ img [ Asset.src Asset.shit ] [] ]
                ]
            ]
    }
