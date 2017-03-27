module Main exposing (..)

import App exposing (..)
import Model exposing (Game)
import Msg exposing (Msg)
import Html exposing (program)

main : Program Never Game Msg
main =
    program { view = view, init = init, update = update, subscriptions = subscriptions }
