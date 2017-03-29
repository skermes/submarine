module View.PlayerIcon exposing (view, maybeView)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (id, class, style)

import Model exposing (Player)
import Msg exposing (Msg)
import View.Icons.DivingHelmet as Helmet

view : Player -> Html Msg
view player =
  div [ class "player"
      , style [("fill", player.color)]
      ]
      [ Helmet.icon ]

maybeView : Maybe Player -> Html Msg
maybeView player =
  case player of
    Nothing -> div [ class "player" ] [ ]
    Just player -> view player
