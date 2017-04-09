module App exposing (..)

import Html exposing (Html, text, div, img, span)
import Html.Attributes exposing (src, class, style)
import List
import String
import Random
import Random.List exposing (shuffle)
import Array exposing (Array)

import Msg exposing (..)
import Model exposing (..)
import View.Submarine
import View.PlayerSummary
import View.Path
import View.Actions

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
      , lastDieRoll = Nothing
      }, Random.generate NewPath (shuffle startingTreasure) )

shuffledTreasureToPath : (List Treasure) -> (List Spot)
shuffledTreasureToPath treasure =
  treasure
    |> List.sortBy (\t -> tokenGroup t)
    |> List.map (\t -> (Spot Nothing (TreasureToken t)))

movePlayer : Position -> Direction -> Int -> (Array Spot) -> Position
movePlayer position direction distance path =
  if distance <= 0 then
    position
  else
    case position of
      InSubmarine ->
        case direction of
          TowardsSub -> position
          AwayFromSub ->
            case (Array.get 0 path) of
              Nothing -> position
              Just spot ->
                case spot.player of
                  Nothing -> movePlayer (OnPath 0) direction (distance - 1) path
                  Just _ -> movePlayer (OnPath 0) direction distance path
      OnPath idx ->
        let offset = (if direction == TowardsSub then -1 else 1)
        in
          case (Array.get (idx + offset) path) of
            Nothing ->
              case direction of
                TowardsSub -> InSubmarine
                AwayFromSub -> position
            Just spot ->
              case spot.player of
                Nothing -> movePlayer (OnPath (idx + offset)) direction (distance - 1) path
                Just _ -> movePlayer (OnPath (idx + offset)) direction distance path

update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
    case msg of
      NoOp -> ( game, Cmd.none )
      NewPath shuffledTreasure -> ( { game | path = (shuffledTreasureToPath shuffledTreasure) }
                                  , Cmd.none )
      Roll -> ( game, Random.generate NewRoll (Random.pair (Random.int 1 3) (Random.int 1 3)) )
      NewRoll (x, y) -> ( { game | lastDieRoll = (Just (x + y)) }
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
                     , [ View.Path.view game.path game.players ]
                     , [ View.Actions.view game ]
                     ])

subscriptions : Game -> Sub Msg
subscriptions game =
    Sub.none
