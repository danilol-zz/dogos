module Styles exposing
    ( button
    , buttonHome
    , buttonLarge
    , buttonSearch
    , container
    , dataHeader
    , dataSubHeader
    , disabled
    , editEmailClose
    , editEmailSave
    , header
    , heroContainer
    , input
    , inputGroup
    , linkPurple
    , logo
    , resetStyles
    , row
    , shadow
    , statusBadge
    , statusBadgeActive
    , statusBadgeInactive
    , statusBadgeIssued
    , table
    , tableResponsive
    , tableStriped
    , textCenter
    )

import Css
    exposing
        ( Style
        , alignItems
        , auto
        , backgroundClip
        , backgroundColor
        , batch
        , block
        , border3
        , borderBottom3
        , borderBottomLeftRadius
        , borderBottomRightRadius
        , borderCollapse
        , borderColor
        , borderRadius
        , borderRadius4
        , borderTop3
        , borderTopLeftRadius
        , borderTopRightRadius
        , bottom
        , center
        , collapse
        , color
        , cursor
        , display
        , displayFlex
        , flexWrap
        , fontFamilies
        , fontSize
        , fontWeight
        , height
        , hex
        , hover
        , inlineBlock
        , int
        , left
        , lineHeight
        , margin
        , marginBottom
        , marginLeft
        , marginRight
        , maxWidth
        , middle
        , none
        , nthOfType
        , num
        , opacity
        , overflowX
        , padding
        , padding2
        , padding4
        , paddingBox
        , paddingLeft
        , paddingRight
        , pct
        , pointer
        , position
        , px
        , relative
        , rem
        , rgba
        , solid
        , stretch
        , table
        , textAlign
        , textDecoration
        , top
        , transparent
        , verticalAlign
        , width
        , wrap
        , zero
        )
import Css.Global as Global



-- STYLES


dataHeader : Style
dataHeader =
    batch
        [ backgroundColor (hex "4fa756")
        , padding (px 20)
        , color (hex "f6c9d9")
        ]


dataSubHeader : Style
dataSubHeader =
    batch
        [ backgroundColor (hex "783258")
        , padding2 (px 10) (px 20)
        , color (hex "f6c9d9")
        ]


tableResponsive : Style
tableResponsive =
    batch
        [ display block
        , width (pct 100)
        , overflowX auto
        ]


table : Style
table =
    batch
        [ width (pct 100)
        , color (hex "212529")
        , borderCollapse collapse
        , Global.children
            [ Global.thead
                [ Global.children
                    [ Global.tr
                        [ Global.children
                            [ Global.th
                                [ verticalAlign bottom
                                , padding (rem 1)
                                , textAlign left
                                ]
                            ]
                        ]
                    ]
                ]
            , Global.tbody
                [ Global.children
                    [ Global.tr
                        [ Global.children
                            [ Global.td
                                [ padding (rem 1)
                                , paddingLeft (px 20)
                                , verticalAlign top
                                , borderTop3 (px 1) solid (hex "dee2e6")
                                , textAlign left
                                ]
                            , Global.th
                                [ padding2 (px 10) (px 20)
                                , verticalAlign top
                                , borderTop3 (px 1) solid (hex "dee2e6")
                                , textAlign left
                                ]
                            ]
                        ]
                    , Global.thead
                        [ Global.children
                            [ Global.th
                                [ verticalAlign bottom
                                , borderBottom3 (px 2) solid (hex "dee2e6")
                                , textAlign left
                                ]
                            ]
                        ]
                    , Global.tbody
                        [ Global.children
                            [ Global.typeSelector "tbody"
                                [ borderTop3 (px 2) solid (hex "dee2e6")
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


tableStriped : Style
tableStriped =
    batch
        [ Global.children
            [ Global.tbody
                [ Global.children
                    [ Global.tr
                        [ nthOfType "odd"
                            [ backgroundColor (rgba 0 0 0 0.05)
                            ]
                        ]
                    ]
                ]
            ]
        ]


shadow : Style
shadow =
    batch
        [ Css.property "box-shadow" <| "0px 0px 25px -1px rgba(0,0,0,0.36)"
        , marginBottom (rem 1)
        ]


container : Style
container =
    batch
        [ width (pct 100)
        , maxWidth (px 1140)
        , paddingLeft (px 15)
        , paddingRight (px 15)
        , marginLeft auto
        , marginRight auto
        ]


heroContainer : Style
heroContainer =
    batch
        [ Css.property "display" <| "grid"
        , Css.property "grid-template-columns" <| " 1fr 1fr"
        , Css.property "align-items" <| "center"
        , color (hex "4fa756")
        ]


row : Style
row =
    batch
        [ displayFlex
        , marginLeft (px -15)
        , marginLeft (px -15)
        ]


resetStyles : Style
resetStyles =
    batch
        [ padding zero
        , margin zero
        , fontFamilies [ "BlinkMacSystemFont", "Segoe UI", "Roboto", "Helvetica Neue", "Arial", "Noto Sans", "sans-serif" ]
        ]


header : Style
header =
    batch
        [ backgroundColor (hex "4fa756")
        , borderBottom3 (px 1) solid (hex "95ffc5")
        , padding4 (px 30) (px 0) (px 30) (px 0)
        ]


button : Style
button =
    batch
        [ display inlineBlock
        , fontWeight (int 400)
        , color (hex "212529")
        , textAlign center
        , Css.property "user-select" <| "none"
        , verticalAlign middle
        , backgroundColor (hex "343a40")
        , color (hex "fff")
        , border3 (px 1) solid transparent
        , padding2 (rem 0.375) (rem 0.75)
        , fontSize (rem 1)
        , lineHeight (num 1.5)
        , borderRadius (rem 0.25)
        , cursor pointer
        , textDecoration none
        , Css.property "transition" <| "all ease .3s"
        ]


buttonLarge : Style
buttonLarge =
    batch
        [ padding2 (rem 0.5) (rem 1)
        , fontSize (rem 1.25)
        , lineHeight (num 1.5)
        , borderRadius (rem 0.3)
        ]


buttonHome : Style
buttonHome =
    batch
        [ color (hex "e12974")
        , borderColor (hex "e12974")
        , backgroundColor transparent
        , hover
            [ backgroundColor (hex "e12974")
            , color (hex "fff")
            ]
        ]


buttonSearch : Style
buttonSearch =
    batch
        [ backgroundColor (hex "783158")
        , borderRadius4 zero (px 5) (px 5) zero
        ]


inputGroup : Style
inputGroup =
    batch
        [ position relative
        , displayFlex
        , flexWrap wrap
        , alignItems stretch
        , width (pct 100)
        ]


input : Style
input =
    batch
        [ display block
        , width (pct 100)

        -- , height calc(1.5em + .75rem + 2px);
        , padding2 (rem 0.375) (rem 0.75)
        , fontSize (rem 1)
        , fontWeight (int 400)
        , lineHeight (num 1.5)
        , color (hex "495057")
        , backgroundColor (hex "fff")
        , backgroundClip paddingBox
        , border3 (px 1) solid (hex "ced4da")
        , borderRadius (rem 0.25)
        , position relative
        , Css.property "flex" <| "1 1 auto"
        , width (pct 1)
        , marginBottom zero
        ]


editEmailClose : Style
editEmailClose =
    batch
        [ display inlineBlock
        , width (px 40)
        , height (px 40)
        , lineHeight (px 40)
        , verticalAlign top
        , borderBottomLeftRadius (px 4)
        , borderTopLeftRadius (px 4)
        , textAlign center
        , color (hex "fff")
        , cursor pointer
        , backgroundColor (hex "db3545")
        ]


editEmailSave : Style
editEmailSave =
    batch
        [ display inlineBlock
        , width (px 40)
        , height (px 40)
        , lineHeight (px 40)
        , verticalAlign top
        , borderBottomRightRadius (px 4)
        , borderTopRightRadius (px 4)
        , textAlign center
        , color (hex "fff")
        , cursor pointer
        , backgroundColor (hex "28a745")
        ]


disabled : Style
disabled =
    batch
        [ opacity (0.5 |> num)
        ]


textCenter : Style
textCenter =
    batch
        [ textAlign center
        ]


logo : Style
logo =
    batch
        [ display block
        , width (px 110)
        ]


statusBadge : Style
statusBadge =
    batch
        [ padding2 (px 6) (px 12)
        , borderRadius (px 30)
        , display inlineBlock
        , backgroundColor transparent
        , color (hex "fff")
        ]


statusBadgeActive : Style
statusBadgeActive =
    batch
        [ backgroundColor (hex "28a745")
        ]


statusBadgeIssued : Style
statusBadgeIssued =
    batch
        [ backgroundColor (hex "ffc107")
        ]


statusBadgeInactive : Style
statusBadgeInactive =
    batch
        [ backgroundColor (hex "dc3545")
        ]


linkPurple : Style
linkPurple =
    batch
        [ color (hex "7b31e7")
        , fontSize (px 12)
        , marginLeft (px 10)
        , cursor pointer
        ]
