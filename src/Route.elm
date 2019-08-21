module Route exposing
    ( Route(..)
    , fromUrl
    , href
    , replaceUrl
    )

import Browser.Navigation as Nav
import Html.Styled as Styled
import Html.Styled.Attributes as StyledAttr
import Url exposing (Url)
import Url.Parser as Parser
    exposing
        ( (<?>)
        , Parser
        , oneOf
        , s
        )
import Url.Parser.Query as Query



-- ROUTING


type Route
    = Root
    | Home
    | Dog (Maybe String)


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map Dog (s "dog" <?> Query.string "breed")
        ]



-- PUBLIC HELPERS


href : Route -> Styled.Attribute msg
href targetRoute =
    StyledAttr.href (routeToString targetRoute)


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
    Nav.replaceUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    -- The RealWorld spec treats the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    { url | path = url.path, fragment = Nothing, query = url.query }
        |> Parser.parse parser



-- INTERNAL


routeToString : Route -> String
routeToString route =
    let
        pieces =
            case route of
                Home ->
                    []

                Root ->
                    []

                Dog email ->
                    case email of
                        Nothing ->
                            [ "dog" ]

                        Just e ->
                            [ "dog", "breed=" ++ e ]
    in
    "/" ++ String.join "?" pieces
