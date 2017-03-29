module View.Path exposing (view)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (id, class, style)
import List
import Array exposing (Array)

import Model exposing (Player, Token, Spot)
import Msg exposing (Msg)
import View.Token as Token
import View.PlayerIcon as PlayerIcon

maybePlayer : Array Player -> Maybe Int -> Html Msg
maybePlayer players idx =
  case idx of
    Nothing -> div [] []
    Just i -> PlayerIcon.maybeView (Array.get i players)

spotView : Array Player -> Spot -> Html Msg
spotView players spot =
  div [ class "spot" ]
      [ Token.faceDown spot.token
      , maybePlayer players spot.player
      ]

view : List Spot -> List Player -> Html Msg
view path players =
  div [ class "path" ]
      (List.map (spotView (Array.fromList players)) path)