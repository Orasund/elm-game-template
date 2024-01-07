module Random.Extra exposing (..)

import Random exposing (Generator, Seed)


shuffle : List a -> Generator (List a)
shuffle list =
    Random.float 0 1
        |> Random.list (List.length list)
        |> Random.map
            (\randList ->
                List.map2 Tuple.pair
                    randList
                    list
                    |> List.sortBy Tuple.first
                    |> List.map Tuple.second
            )


apply : Generator { model | seed : Seed } -> { model | seed : Seed } -> { model | seed : Seed }
apply gen model =
    let
        ( newModel, seed ) =
            Random.step gen model.seed
    in
    { newModel | seed = seed }
