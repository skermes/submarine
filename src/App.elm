module App exposing (..)

import Html exposing (Html, text, div, img, span)
import Html.Attributes exposing (src, class, style)
import List
import String

import Msg exposing (Msg)
import Model exposing (..)
import View.Submarine
import View.PlayerSummary
import View.Path

startingPlayer : String -> String -> Player
startingPlayer color name =
    { color = color
    , name = name
    , holding = [ ]
    , scored = [ ]
    }

init : ( Game, Cmd Msg )
init =
    ( { airCapacity = 25
      , remainingAir = 15
      , path = [ Spot Nothing (TreasureToken 1)
               , Spot Nothing (TreasureToken 0)
               , Spot Nothing (TreasureToken 4)
               , Spot Nothing BlankToken
               , Spot Nothing (TreasureToken 10)
               , Spot Nothing (TreasureToken 15)
               , Spot Nothing (TreasureToken 12)
               ]
      , inSubmarine = [0, 1]
      , players = [ startingPlayer "#D80C27" "Alice"
                  , startingPlayer "#07387A" "Bob" ]
      }, Cmd.none )

update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
    ( game, Cmd.none )

pathView : Game -> Html Msg
pathView game =
    div [ class "path" ]
        [ span [] [ text (String.join " " (List.map toString game.path))]]

view : Game -> Html Msg
view game =
    div [ class "board" ]
        (List.concat [ List.map View.PlayerSummary.view game.players
                     , [ View.Submarine.view game ]
                     , [ View.Path.view game.path game.players ]])

subscriptions : Game -> Sub Msg
subscriptions game =
    Sub.none
