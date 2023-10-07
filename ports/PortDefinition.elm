module PortDefinition exposing (Flags, FromElm(..), ToElm(..), interop)

import Gen.Sound as Sound exposing (Sound)
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


type ToElm
    = SoundEnded Sound


type alias Flags =
    {}


fromElm : Encoder FromElm
fromElm =
    TsEncode.union
        (\playSound registerSounds value ->
            case value of
                RegisterSounds list ->
                    registerSounds list

                PlaySound args ->
                    playSound args
        )
        |> TsEncode.variantTagged "playSound"
            (TsEncode.object
                [ TsEncode.required "sound" (\obj -> obj.sound |> Sound.toString) TsEncode.string
                , TsEncode.required "looping" .looping TsEncode.bool
                ]
            )
        |> TsEncode.variantTagged "registerSounds"
            (TsEncode.list (TsEncode.string |> TsEncode.map Sound.toString))
        |> TsEncode.buildUnion


toElm : Decoder ToElm
toElm =
    TsDecode.discriminatedUnion "type"
        [ ( "soundEnded"
          , TsDecode.string
                |> TsDecode.andThen
                    (TsDecode.andThenInit
                        (\string ->
                            string
                                |> Sound.fromString
                                |> Maybe.map (\sound -> SoundEnded sound |> TsDecode.succeed)
                                |> Maybe.withDefault (TsDecode.fail ("Unkown sound ended: " ++ string))
                        )
                    )
          )
        ]


flags : Decoder Flags
flags =
    TsDecode.null {}
