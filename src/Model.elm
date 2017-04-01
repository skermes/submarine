module Model exposing (..)

type alias Treasure = Int

-- TODO: extend this to extend this to handle stacks of treasure.  Adding a
-- | List Treasure on seems a little to simplistic?
type Token = BlankToken | TreasureToken Treasure

type alias Player =
    { color : String
    , name : String
    -- I would like to express here that players can only hold and score
    -- treasure tokens, but I can't get it to recognize TreasureToken as a type.
    , holding : List Token
    , scored : List Token
    }

type alias Spot =
    { player : Maybe Int
    , token : Token }

-- Is there a better way to arrange this?  What if instead of having players
-- store their position we expanded the Token type to include the player at
-- that position?
type alias Game =
    { airCapacity : Int
    , remainingAir : Int
    , path : List Spot
    , inSubmarine : List Int
    , players : List Player
    }

tokenGroup : Treasure -> Int
tokenGroup value =
    (value // 4) + 1