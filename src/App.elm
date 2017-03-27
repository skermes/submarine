module App exposing (..)

import Html exposing (Html, text, div, img, span)
import Html.Attributes exposing (src, class, style)
import List
import String

import Msg exposing (Msg)
import Model exposing (..)
import View.Submarine

startingPlayer : String -> String -> Player
startingPlayer color name =
    { color = color
    , name = name
    , position = 0
    , holding = [ ]
    , scored = [ ]
    }

init : ( Game, Cmd Msg )
init =
    ( { airCapacity = 25
      , remainingAir = 15
      , path = [ TreasureToken 1, TreasureToken 2, BlankToken, BlankToken, TreasureToken 7, BlankToken, TreasureToken 9 ]
      , players = [startingPlayer "#D80C27" "Alice", startingPlayer "#07387A" "Bob"]
      }, Cmd.none )

update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
    ( game, Cmd.none )

playerView : Player -> Html Msg
playerView player =
    div [ class "player" ]
        [ span [ style [("color", player.color)]] [ text player.name]
        , span [] [ text ("At: " ++ (toString player.position)) ]
        , span [] [ text ("Scored: " ++ String.join " " (List.map toString player.scored))]
        , span [] [ text ("Holding: " ++ String.join " " (List.map toString player.holding))]
        ]

pathView : Game -> Html Msg
pathView game =
    div [ class "path" ]
        [ span [] [ text (String.join " " (List.map toString game.path))]]

view : Game -> Html Msg
view game =
    div [ class "board" ]
        (List.concat [ List.map playerView game.players
                     , [ View.Submarine.view game ]
                     , [ pathView game ]])

subscriptions : Game -> Sub Msg
subscriptions game =
    Sub.none
