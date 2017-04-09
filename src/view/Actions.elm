module View.Actions exposing (view)

import Html exposing (Html, div, span, text, button)
import Html.Attributes exposing (id, class, style)
import Html.Events exposing (onClick)

import Model exposing (Game)
import Msg exposing (..)

rollText : Maybe Int -> Html Msg
rollText roll =
  case roll of
    Nothing -> text ""
    Just x -> text (toString x)

view : Game -> Html Msg
view game =
  div [ class "actions" ]
      [ div [ class "action-message" ] [ rollText game.lastDieRoll ]
      , div [ class "action-roll" ]
            [ button [ class "button button-roll", onClick Roll ] [ text "roll" ] ]
      ]