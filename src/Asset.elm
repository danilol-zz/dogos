module Asset exposing
    ( Image
    , dynamicImage
    , elmIcon
    , error
    , loading
    , logo
    , sadUnicorn
    , shit
    , src
    , unicorn
    )

{-| Assets, such as images, videos, and audio. (We only have images for now.)

We should never expose asset URLs directly; this module should be in charge of
all of them. One source of truth!

-}

import Html.Styled exposing (Attribute)
import Html.Styled.Attributes as Attr


type Image
    = Image String



-- IMAGES


logo : Image
logo =
    image "elm-logo.png"


elmIcon : Image
elmIcon =
    image "elm-icon.png"


shit : Image
shit =
    image "shit.gif"


unicorn : Image
unicorn =
    image "unicorn.png"


error : Image
error =
    image "error.jpeg"


loading : Image
loading =
    image "dogo.gif"


sadUnicorn : Image
sadUnicorn =
    image "sad_unicorn.png"


image : String -> Image
image filename =
    Image ("/assets/images/" ++ filename)


dynamicImage : String -> Image
dynamicImage path =
    Image path



-- USING IMAGES


src : Image -> Attribute msg
src (Image url) =
    Attr.src url
