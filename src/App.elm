module App exposing (..)

import Html exposing (Html, text, div, img, span)
import Html.Attributes exposing (src, class, style)
import List
import String

type alias Treasure = Int

-- TODO: extend this to extend this to handle stacks of treasure.  Adding a
-- | List Treasure on seems a little to simplistic?
type Token = BlankToken | TreasureToken Treasure

type alias Player =
    { color : String
    , name : String
    -- We can do it like this where 0 is in the sub, or maybe a union type of
    -- like InSubmarine | OnPath Int ?
    , position : Int
    , holding : List Treasure
    , scored : List Treasure
    }

-- Is there a better way to arrange this?  What if instead of having players
-- store their position we expanded the Token type to include the player at
-- that position?
type alias Model =
    { airCapacity : Int
    , remainingAir : Int
    , path : List Token
    , players : List Player
    }

startingPlayer : String -> String -> Player
startingPlayer color name =
    { color = color
    , name = name
    , position = 0
    , holding = [ ]
    , scored = [ ]
    }

init : ( Model, Cmd Msg )
init =
    ( { airCapacity = 25
      , remainingAir = 25
      , path = [ TreasureToken 1, TreasureToken 2, BlankToken, BlankToken, TreasureToken 7, BlankToken, TreasureToken 9 ]
      , players = [startingPlayer "red" "Alice", startingPlayer "blue" "Bob"]
      }, Cmd.none )

type Msg
    = NoOp

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

submarineView : Model -> Html Msg
submarineView model =
    div [ class "submarine" ]
        [ span [] [ text "Air: " ]
        , span [] [ text ((toString model.remainingAir) ++ "/" ++ (toString model.airCapacity)) ]
        ]

playerView : Player -> Html Msg
playerView player =
    div [ class "player" ]
        [ span [ style [("color", player.color)]] [ text player.name]
        , span [] [ text ("At: " ++ (toString player.position)) ]
        , span [] [ text ("Scored: " ++ String.join " " (List.map toString player.scored))]
        , span [] [ text ("Holding: " ++ String.join " " (List.map toString player.holding))]
        ]

pathView : Model -> Html Msg
pathView model =
    div [ class "path" ]
        [ span [] [ text (String.join " " (List.map toString model.path))]]

view : Model -> Html Msg
view model =
    div [ class "board" ]
        (List.concat [ [ submarineView model ]
                     , List.map playerView model.players
                     , [ pathView model ]])

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
