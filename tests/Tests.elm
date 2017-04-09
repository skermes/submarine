module Tests exposing (..)

import Test exposing (..)
import Expect
import Array exposing (Array)

import App exposing (movePlayer)
import Model exposing (..)


all : Test
all =
  describe "Update functions"
    [ describe "movePlayer"
      [ test "zero distance up goes nowhere" <|
          \() ->
            let position = (OnPath 1)
                distance = 0
                direction = TowardsSub
                path = (Array.fromList [(Spot Nothing BlankToken), (Spot (Just 0) BlankToken), (Spot Nothing BlankToken)])
            in
              Expect.equal (movePlayer position direction distance path) position
      , test "zero distance down goes nowhere" <|
          \() ->
            let position = (OnPath 1)
                distance = 0
                direction = AwayFromSub
                path = (Array.fromList [(Spot Nothing BlankToken), (Spot (Just 0) BlankToken), (Spot Nothing BlankToken)])
            in
              Expect.equal (movePlayer position direction distance path) position
      , test "negative distance goes nowhere" <|
        \() ->
            let position = (OnPath 1)
                distance = -2
                direction = AwayFromSub
                path = (Array.fromList [(Spot Nothing BlankToken), (Spot (Just 0) BlankToken), (Spot Nothing BlankToken)])
            in
              Expect.equal (movePlayer position direction distance path) position
      , test "moving up when in sub goes nowhere" <|
        \() ->
          let position = InSubmarine
              distance = 3
              direction = TowardsSub
              path = Array.fromList [(Spot Nothing BlankToken)]
          in
            Expect.equal (movePlayer position direction distance path) position
      , test "moving down when in sub goes onto the path" <|
        \() ->
          let position = InSubmarine
              distance = 2
              direction = AwayFromSub
              path = Array.fromList([(Spot Nothing BlankToken), (Spot Nothing BlankToken), (Spot Nothing BlankToken)])
          in
            Expect.equal (movePlayer position direction distance path) (OnPath 1)
      , test "moving up and overshooting the sub goes into the sub" <|
        \() ->
          let position = (OnPath 1)
              distance = 5
              direction = TowardsSub
              path = Array.fromList([(Spot Nothing BlankToken), (Spot (Just 0) BlankToken), (Spot Nothing BlankToken)])
          in
            Expect.equal (movePlayer position direction distance path) InSubmarine
      , test "moving down and overshooting the end of the path ends on the last spot" <|
        \() ->
          let position = (OnPath 0)
              distance = 5
              direction = AwayFromSub
              path = Array.fromList([(Spot (Just 0) BlankToken), (Spot Nothing BlankToken), (Spot Nothing BlankToken)])
          in
            Expect.equal (movePlayer position direction distance path) (OnPath 2)
      , test "moving down with players in the way skips them" <|
        \() ->
          let position = (OnPath 0)
              distance = 1
              direction = AwayFromSub
              path = Array.fromList([(Spot (Just 0) BlankToken), (Spot (Just 1) BlankToken), (Spot Nothing BlankToken)])
          in
            Expect.equal (movePlayer position direction distance path) (OnPath 2)
      , test "moving up with players in the way skips them" <|
        \() ->
          let position = (OnPath 2)
              distance = 2
              direction = TowardsSub
              path = Array.fromList([(Spot (Just 1) BlankToken), (Spot Nothing BlankToken), (Spot (Just 0) BlankToken)])
          in
            Expect.equal (movePlayer position direction distance path) InSubmarine
      ]
    ]
