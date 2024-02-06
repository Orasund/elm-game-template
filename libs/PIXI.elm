module PIXI exposing (..)

import PIXI.Image exposing (Sprite, SpriteId)
import TsJson.Encode exposing (Encoder)


type PIXIStatement
    = Init String
    | Resize
    | Start
    | Stop
    | Render
    | LoadImages (List ( SpriteId, String ))
    | AddToStage (List Sprite)


{-| Initiate the application as child of a DOM element.

Equivalent to the following JS code

       function init(parent) {
           const app = new PIXI.Application();
           const parentNode = document.getElementById(parent)
           parentNode.appendChild(app.view);
           app.resizeTo(parentNode);
       }

-}
init : { parent : String } -> PIXIStatement
init { parent } =
    Init parent


{-| Resizes the application to the size of the parent
-}
resize : PIXIStatement
resize =
    Resize


{-| Starts the renderer. The render is initially automatically started
-}
start : PIXIStatement
start =
    Start


{-| Stops the renderer
-}
stop : PIXIStatement
stop =
    Stop


{-| Render the current stage
-}
render : PIXIStatement
render =
    Render
