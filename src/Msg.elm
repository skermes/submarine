module Msg exposing (..)

import Model exposing (Treasure)

type Msg
    = NoOp
    | NewPath (List Treasure)
    | Roll
    | NewRoll (Int, Int)