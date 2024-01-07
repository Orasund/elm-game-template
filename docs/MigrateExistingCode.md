# Migrate an existing codebase

Migrating from an existing codebase is quite easy:

1. copy replace the `src` folder with your own
2. in the `init` function, add `Gen.Sound.asList |> RegisterSounds |> Port.fromElm`
3. Add `Received (Result Json.Decode.Error ToElm)` to your `Msg` type
4. Add `Port.toElm |> Sub.map Received` to your subscription function

Done! You're ready to go.