module Breed exposing
    ( Breed
    , breedOptions
    , breedsList
    , toBreed
    )

import String.Extra exposing (toTitleCase)
import Utils.Html exposing (Option)


type alias Breed =
    { text : String
    , value : String
    , selected : Bool
    }


breedsList : List String
breedsList =
    [ "affenpinscher"
    , "african"
    , "airedale"
    , "akita"
    , "appenzeller"
    , "basenji"
    , "beagle"
    , "bluetick"
    , "borzoi"
    , "bouvier"
    , "boxer"
    , "brabancon"
    , "briard"
    , "bulldog/boston"
    , "bulldog/english"
    , "bulldog/french"
    , "bullterrier/staffordshire"
    , "cairn"
    , "cattledog/australian"
    , "chihuahua"
    , "chow"
    , "clumber"
    , "cockapoo"
    , "collie/border"
    , "coonhound"
    , "corgi/cardigan"
    , "cotondetulear"
    , "dachshund"
    , "dalmatian"
    , "dane/great"
    , "deerhound/scottish"
    , "dhole"
    , "dingo"
    , "doberman"
    , "elkhound/norwegian"
    , "entlebucher"
    , "eskimo"
    , "frise/bichon"
    , "germanshepherd"
    , "greyhound/italian"
    , "groenendael"
    , "hound/afghan"
    , "hound/basset"
    , "hound/blood"
    , "hound/english"
    , "hound/ibizan"
    , "hound/walker"
    , "husky"
    , "keeshond"
    , "kelpie"
    , "komondor"
    , "kuvasz"
    , "labrador"
    , "leonberg"
    , "lhasa"
    , "malamute"
    , "malinois"
    , "maltese"
    , "mastiff/bull"
    , "mastiff/english"
    , "mastiff/tibetan"
    , "mexicanhairless"
    , "mix"
    , "mountain/bernese"
    , "mountain/swiss"
    , "newfoundland"
    , "otterhound"
    , "papillon"
    , "pekinese"
    , "pembroke"
    , "pinscher/miniature"
    , "pointer/german"
    , "pointer/germanlonghair"
    , "pomeranian"
    , "poodle/miniature"
    , "poodle/standard"
    , "poodle/toy"
    , "pug"
    , "puggle"
    , "pyrenees"
    , "redbone"
    , "retriever/chesapeake"
    , "retriever/curly"
    , "retriever/flatcoated"
    , "retriever/golden"
    , "ridgeback/rhodesian"
    , "rottweiler"
    , "saluki"
    , "samoyed"
    , "schipperke"
    , "schnauzer/giant"
    , "schnauzer/miniature"
    , "setter/english"
    , "setter/gordon"
    , "setter/irish"
    , "sheepdog/english"
    , "sheepdog/shetland"
    , "shiba"
    , "shihtzu"
    , "spaniel/blenheim"
    , "spaniel/brittany"
    , "spaniel/cocker"
    , "spaniel/irish"
    , "spaniel/japanese"
    , "spaniel/sussex"
    , "spaniel/welsh"
    , "springer/english"
    , "stbernard"
    , "terrier/american"
    , "terrier/australian"
    , "terrier/bedlington"
    , "terrier/border"
    , "terrier/dandie"
    , "terrier/fox"
    , "terrier/irish"
    , "terrier/kerryblue"
    , "terrier/lakeland"
    , "terrier/norfolk"
    , "terrier/norwich"
    , "terrier/patterdale"
    , "terrier/russell"
    , "terrier/scottish"
    , "terrier/sealyham"
    , "terrier/silky"
    , "terrier/tibetan"
    , "terrier/toy"
    , "terrier/westhighland"
    , "terrier/wheaten"
    , "terrier/yorkshire"
    , "vizsla"
    , "weimaraner"
    , "whippet"
    , "wolfhound/irish"
    ]


toBreed : String -> Bool -> Breed
toBreed breedName selected =
    { text = toTitleCase breedName
    , value = breedName
    , selected = selected
    }


breedOptions : String -> List Option
breedOptions breed =
    List.map (\b -> toBreed b (breed == b)) breedsList
