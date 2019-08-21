module Utils.Html exposing
    ( Option
    , className
    , emptyHtml
    , select
    )

import Html.Styled as Styled exposing (Attribute, Html, div, option, text)
import Html.Styled.Attributes as Attrs
import Html.Styled.Events exposing (on, targetValue)
import Json.Decode exposing (map)


emptyHtml : Html msg
emptyHtml =
    Styled.text ""


className : String -> Attribute msg
className value =
    Attrs.class value



-- Types


type alias Value =
    String


type alias Option =
    { text : String
    , value : Value
    , selected : Bool
    }



-- View


optionToHtml : Option -> Html msg
optionToHtml opt =
    option
        [ Attrs.value opt.value
        , Attrs.selected opt.selected
        ]
        [ text opt.text ]


optionsToHtml : List Option -> List (Html msg)
optionsToHtml options =
    defaultOption :: List.map optionToHtml options


defaultOption : Html msg
defaultOption =
    option
        [ Attrs.value "random"
        , Attrs.selected False
        ]
        [ text "Random" ]


select : List Option -> Html Value
select options =
    div []
        [ Styled.select
            [ on "change" (map (\value -> value) targetValue) ]
            (optionsToHtml options)
        ]
