module App exposing (..)

import Html exposing (Html, text, div, img, span)
import Html.Attributes exposing (src, class, style)
import List
import String
import Random
import Random.List exposing (shuffle)

import Msg exposing (Msg(NoOp, NewPath))
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
    , position = InSubmarine
    }

startingTreasure : List Treasure
startingTreasure =
  [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11
  , 12, 12, 13, 13, 14, 14, 15, 15]

init : ( Game, Cmd Msg )
init =
    ( { airCapacity = 25
      , remainingAir = 25
      , path = [ ]
      , inSubmarine = [0, 1, 2]
      , players = [ startingPlayer "#D80C27" "Alice"
                  , startingPlayer "#07387A" "Bob"
                  , startingPlayer "#EB6317" "Charlie" ]
      , activePlayer = 0
      }, Random.generate NewPath (shuffle startingTreasure) )

shuffledTreasureToPath : (List Treasure) -> (List Spot)
shuffledTreasureToPath treasure =
  treasure
    |> List.sortBy (\t -> tokenGroup t)
    |> List.map (\t -> (Spot Nothing (TreasureToken t)))

update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
    case msg of
      NoOp -> ( game, Cmd.none )
      NewPath shuffledTreasure -> ( { game | path = (shuffledTreasureToPath shuffledTreasure) }
                                  , Cmd.none )

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
