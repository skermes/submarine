module Submarine exposing (view)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (id, class, style)
import List

import Model exposing (Game, Player)
import Msg exposing (Msg)

airPip : Int -> Int -> Int -> Html Msg
airPip capacity remaining i =
  span [ class "air-pip-space"]
       (if remaining + i == capacity then [ span [ class "air-pip-marker" ] [] ] else [])

airSupply : Game -> Html Msg
airSupply game =
  div [ class "air-supply" ]
      (List.map (airPip game.airCapacity game.remainingAir) (List.range 0 (game.airCapacity - 1)))

player : Player -> Html Msg
player p =
  div [ class "player"
      , style [("color", p.color)]
      ]
      [ text p.name ]

subPlayers : List Player -> Html Msg
subPlayers players =
  div [ class "submarine-players" ]
      (List.map player (List.filter (\p -> p.position == 0) players))

view : Game -> Html Msg
view game =
  div [ class "submarine" ]
      [ airSupply game
      , subPlayers game.players
      ]
