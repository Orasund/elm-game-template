# Sound

To play sound, two things must have happend before:

1. The user has already interacted with the game. Like clicking a button or setting the focus on an element of the game.
2. The file has to be loaded.

This repository comes with a sound engine, located at `assets/js/sound.js`, that takes care of these two things.

## Adding a new Sound

To add a new Sound to the system, you have to

1. Place the file inside `asserts\sounds`, and
2. Run `npm run generateSound`(See [docs](/docs/Scripts.md#generatesoundelmjs) for more info). This will generate the file `generated/Gen/Sound.elm` containing a representation of your Sounds.

## Play Sound

```
import PortDefinition exposing (FromElm(..))

--Playing the sound "ClickButton.mp3"
PlaySound { sound = ClickButton, looping = False }
    |> InteropPorts.fromElm
```