module Point exposing (..)


zero : ( number, number )
zero =
    ( 0, 0 )


vecTo : ( number, number ) -> ( number, number ) -> ( number, number )
vecTo ( x1, y1 ) ( x2, y2 ) =
    ( x1 - x2, y1 - y2 )


add : ( number, number ) -> ( number, number ) -> ( number, number )
add ( x1, y1 ) ( x2, y2 ) =
    ( x1 + x2, y1 + y2 )


asGrid : { columns : Int, rows : Int } -> List ( Int, Int )
asGrid args =
    List.range 0 (args.columns - 1)
        |> List.concatMap
            (\x ->
                List.range 0 (args.rows - 1)
                    |> List.map (Tuple.pair x)
            )
