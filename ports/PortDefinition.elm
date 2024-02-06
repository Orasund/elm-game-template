module PortDefinition exposing (Flags, FromElm(..), ToElm, interop)

import Gen.Sound exposing (Sound)
import PIXI exposing (PIXIStatement(..))
import TsJson.Decode as TsDecode exposing (Decoder)
import TsJson.Encode as TsEncode exposing (Encoder)


interop :
    { toElm : Decoder ToElm
    , fromElm : Encoder FromElm
    , flags : Decoder Flags
    }
interop =
    { toElm = toElm
    , fromElm = fromElm
    , flags = flags
    }


type FromElm
    = RegisterSounds (List Sound)
    | PlaySound { sound : Sound, looping : Bool }
    | StopSound Sound
    | ToPIXI PIXIStatement


type ToElm
    = SoundEnded Sound


type alias Flags =
    {}


encoderPIXIStatement : Encoder PIXIStatement
encoderPIXIStatement =
    TsEncode.union
        (\init resize start stop render loadImages addToStage value ->
            case value of
                Init string ->
                    init string

                Resize ->
                    resize ()

                Start ->
                    start ()

                Stop ->
                    stop ()

                Render ->
                    render ()

                LoadImages list ->
                    loadImages list

                AddToStage list ->
                    addToStage list
        )
        |> TsEncode.variantTagged "init" TsEncode.string
        |> TsEncode.variantTagged "resize" TsEncode.null
        |> TsEncode.variantTagged "start" TsEncode.null
        |> TsEncode.variantTagged "stop" TsEncode.null
        |> TsEncode.variantTagged "render" TsEncode.null
        |> TsEncode.variantTagged "loadImage"
            (TsEncode.tuple TsEncode.string TsEncode.string
                |> TsEncode.list
            )
        |> TsEncode.variantTagged "addToStage"
            ([ TsEncode.required "id" .id TsEncode.string
             , TsEncode.required "height" .height (TsEncode.maybe TsEncode.float)
             , TsEncode.required "width" .width (TsEncode.maybe TsEncode.float)
             ]
                |> TsEncode.object
                |> TsEncode.list
            )
        |> TsEncode.buildUnion


fromElm : Encoder FromElm
fromElm =
    let
        soundEncoder =
            TsEncode.string |> TsEncode.map Gen.Sound.toString
    in
    TsEncode.union
        (\playSound stopSound registerSounds toPIXI value ->
            case value of
                RegisterSounds list ->
                    registerSounds list

                PlaySound args ->
                    playSound args

                StopSound args ->
                    stopSound args

                ToPIXI union ->
                    toPIXI union
        )
        |> TsEncode.variantTagged "playSound"
            (TsEncode.object
                [ TsEncode.required "sound" (\obj -> obj.sound |> Gen.Sound.toString) TsEncode.string
                , TsEncode.required "looping" .looping TsEncode.bool
                ]
            )
        |> TsEncode.variantTagged "stopSound" soundEncoder
        |> TsEncode.variantTagged "registerSounds" (TsEncode.list soundEncoder)
        |> TsEncode.variantTagged "toPIXI" encoderPIXIStatement
        |> TsEncode.buildUnion


toElm : Decoder ToElm
toElm =
    TsDecode.discriminatedUnion "type"
        [ ( "soundEnded"
          , TsDecode.succeed SoundEnded
                |> TsDecode.andMap
                    (TsDecode.field "sound"
                        (TsDecode.string
                            |> TsDecode.andThen
                                (TsDecode.andThenInit
                                    (\string ->
                                        string
                                            |> Gen.Sound.fromString
                                            |> Maybe.map TsDecode.succeed
                                            |> Maybe.withDefault (TsDecode.fail ("Unkown sound ended: " ++ string))
                                    )
                                )
                        )
                    )
          )
        ]


flags : Decoder Flags
flags =
    TsDecode.null {}
