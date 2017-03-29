module View.PlayerSummary exposing (view)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (id, class, style)
import List

import Model exposing (Game, Player, Token)
import Msg exposing (Msg)
import View.Token as Token

tokenContainer : String -> (Token -> Html Msg) -> List Token -> Html Msg
tokenContainer label tokenView tokens =
  div [ class "token-container" ]
      (List.concat [ [ span [ class "label" ] [ text label ] ]
                   , List.map tokenView tokens
                   ])

view : Player -> Html Msg
view player =
  div [ class "player-summary", style [("background-color", player.color)]]
      [ span [ class "name" ] [ text player.name ]
      , tokenContainer "Holding" Token.faceDown player.holding
      , tokenContainer "Scored" Token.faceUp player.scored
      ]
