module PIXI.Image exposing (..)


type ImageStatement
    = FromSourceAs { id : String, source : String }
    | FromAsset { id : String }


type alias SpriteId =
    String


type alias Sprite =
    { id : SpriteId
    , width : Maybe Float
    , height : Maybe Float
    }
