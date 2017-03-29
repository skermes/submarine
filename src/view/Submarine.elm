module View.Submarine exposing (view)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (id, class, style)
import List
import Array exposing (Array)

import Model exposing (Game, Player)
import Msg exposing (Msg)
import View.PlayerIcon as PlayerIcon

airPip : Int -> Int -> Int -> Html Msg
airPip capacity remaining i =
  span [ class "air-pip-space"]
       (if remaining + i == capacity then [ span [ class "air-pip-marker" ] [] ] else [])

airSupply : Game -> Html Msg
airSupply game =
  div [ class "air-supply" ]
      (List.map (airPip game.airCapacity game.remainingAir) (List.range 0 (game.airCapacity - 1)))

subPlayers : Array Player -> List Int -> Html Msg
subPlayers players inSubmarine =
  div [ class "submarine-players" ]
      (List.map (\i -> PlayerIcon.maybeView (Array.get i players)) inSubmarine)

view : Game -> Html Msg
view game =
  div [ class "submarine" ]
      [ airSupply game
      , subPlayers (Array.fromList game.players) game.inSubmarine
      ]
