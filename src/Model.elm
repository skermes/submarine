module Model exposing (..)

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
type alias Game =
    { airCapacity : Int
    , remainingAir : Int
    , path : List Token
    , players : List Player
    }