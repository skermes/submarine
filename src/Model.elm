module Model exposing (..)

type alias Treasure = Int

-- TODO: extend this to extend this to handle stacks of treasure.  Adding a
-- | List Treasure on seems a little to simplistic?
type Token = BlankToken | TreasureToken Treasure

type Position = InSubmarine | OnPath Int

type Direction = TowardsSub | AwayFromSub

type alias Player =
    { color : String
    , name : String
    -- I would like to express here that players can only hold and score
    -- treasure tokens, but I can't get it to recognize TreasureToken as a type.
    , holding : List Token
    , scored : List Token
    , position : Position
    }

type alias Spot =
    { player : Maybe Int
    , token : Token }

type alias Game =
    { airCapacity : Int
    , remainingAir : Int
    , path : List Spot
    , inSubmarine : List Int
    , players : List Player
    , activePlayer : Int
    , lastDieRoll : Maybe Int
    }

tokenGroup : Treasure -> Int
tokenGroup value =
    (value // 4) + 1