module Session exposing (Session, fromGuest, navKey)

import Browser.Navigation as Nav



-- TYPES


type Session
    = Guest Nav.Key



-- INFO


navKey : Session -> Nav.Key
navKey session =
    case session of
        Guest key ->
            key



-- CHANGES


fromGuest : Nav.Key -> Session
fromGuest key =
    Guest key
