module View.Token exposing (faceUp, faceDown)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (id, class, style)

import Model exposing (Token(..), Treasure, tokenGroup)
import Msg exposing (Msg)

blank : Html Msg
blank =
  div [ class "token blank-token" ] []

treasureUp : Int -> Html Msg
treasureUp value =
  div [ class ("token treasure-token token-up token-group-" ++ (toString (tokenGroup value))) ]
      [ span [ class "token-content" ] [ text (toString value) ] ]

pip : Int -> Html Msg
pip x =
  span [ class "token-pip" ] []

treasureDown : Int -> Html Msg
treasureDown value =
  div [ class ("token treasure-token token-down token-group-" ++ (toString (tokenGroup value))) ]
      [ span [ class "token-content" ]
             (List.map pip (List.range 1 (tokenGroup value)))
      ]

faceUp : Token -> Html Msg
faceUp token =
  case token of
    BlankToken -> blank
    TreasureToken value -> treasureUp value

faceDown : Token -> Html Msg
faceDown token =
  case token of
    BlankToken -> blank
    TreasureToken value -> treasureDown value
