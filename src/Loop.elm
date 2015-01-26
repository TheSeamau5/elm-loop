module Loop where

import Native.Loop

loopWhile : (state -> Bool) -> state -> (state -> state) -> state
loopWhile = Native.Loop.loopWhile

loopUntil : (state -> Bool) -> state -> (state -> state) -> state
loopUntil = Native.Loop.loopUntil

loopWhileWithResult : (state -> Bool) -> state -> (state -> state) -> (state -> result) -> result
loopWhileWithResult = Native.Loop.loopWhileWithResult

loopUntilWithResult : (state -> Bool) -> state -> (state -> state) -> (state -> result) -> result
loopUntilWithResult = Native.Loop.loopUntilWithResult


iterate : Int -> state -> (state -> state) -> state
iterate = Native.Loop.iterate

iterateOver : Int -> Int -> (Int -> Int) -> state -> (state -> state) -> state
iterateOver = Native.Loop.iterateOver
