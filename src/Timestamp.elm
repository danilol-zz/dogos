module Timestamp exposing (format, view)

import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (class)
import Time exposing (Month(..))



-- VIEW


view : Time.Zone -> Maybe Time.Posix -> Html msg
view timeZone timestamp =
    case timestamp of
        Nothing ->
            span [ class "date" ] [ text "--" ]

        Just t ->
            span [ class "date" ] [ text (format timeZone t) ]



-- FORMAT


{-| Format a timestamp as a String, like so:

    "February 14, 2018"

For more complex date formatting scenarios, here's a nice package:
<https://package.elm-lang.org/packages/ryannhg/date-format/latest/>

-}
format : Time.Zone -> Time.Posix -> String
format zone time =
    let
        month =
            case Time.toMonth zone time of
                Jan ->
                    "January"

                Feb ->
                    "February"

                Mar ->
                    "March"

                Apr ->
                    "April"

                May ->
                    "May"

                Jun ->
                    "June"

                Jul ->
                    "July"

                Aug ->
                    "August"

                Sep ->
                    "September"

                Oct ->
                    "October"

                Nov ->
                    "November"

                Dec ->
                    "December"

        day =
            String.fromInt (Time.toDay zone time)

        year =
            String.fromInt (Time.toYear zone time)
    in
    month ++ " " ++ day ++ ", " ++ year
