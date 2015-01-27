module Loop where

{-| Native library to get loops in Elm without Trampolines
    and without blowing your stack.

@docs loopWhile, loopUntil, loopWhileWithResult, loopUntilWithResult, iterate, iterateOver
-}

import Native.Loop

{-| Loop while a condition is true given an initial state and a
    state transition function (think the body of the loop)

    counter =
      loopWhile (\{counter} -> counter <= 10)
                {counter = 0}
                (\{counter} -> {counter = counter + 1})


    counter -- {counter = 10}
-}
loopWhile : (state -> Bool) -> state -> (state -> state) -> state
loopWhile = Native.Loop.loopWhile


{-| Loop until a condition is true given an initial state and a
    state transition function (think the body of the loop)

    counter =
      loopUntil (\{counter} -> counter > 10)
                {counter = 0}
                (\{counter} -> {counter = counter + 1})


    counter -- {counter = 10}
-}
loopUntil : (state -> Bool) -> state -> (state -> state) -> state
loopUntil = Native.Loop.loopUntil


{-| Loop while a condition is true given an initial state, a
    state transition function (think the body of the loop),
    and a result function. This result function is useful
    because the state of the loop contains all the temporary
    variables used and you might not want the loop to output
    all of these variables. Think of the result function as
    a way to filter the variables, if that helps.

    counter =
      loopWhileWithResult (\{counter} -> counter <= 10)
                          {counter = 0}
                          (\{counter} -> {counter = counter + 1})
                          .counter


    counter -- 10
-}
loopWhileWithResult : (state -> Bool) -> state -> (state -> state) -> (state -> result) -> result
loopWhileWithResult = Native.Loop.loopWhileWithResult



{-| Loop until a condition is true given an initial state, a
    state transition function (think the body of the loop),
    and a result function. This result function is useful
    because the state of the loop contains all the temporary
    variables used and you might not want the loop to output
    all of these variables. Think of the result function as
    a way to filter the variables, if that helps.

    counter =
      loopUntilWithResult (\{counter} -> counter > 10)
                          {counter = 0}
                          (\{counter} -> {counter = counter + 1})
                          .counter


    counter -- 10
-}
loopUntilWithResult : (state -> Bool) -> state -> (state -> state) -> (state -> result) -> result
loopUntilWithResult = Native.Loop.loopUntilWithResult


{-| Works like a for-loop. Iterate from 0 until the given limit
    given an initial state and a state transition function.

    counter =
      iterate 10 0 ((+) 1)

    counter -- 10
-}
iterate : Int -> state -> (state -> state) -> state
iterate = Native.Loop.iterate


{-| Works like a for-loop. Iterate from a start counter to an end
    value given a step function to increment the counter.

    counter =
      iterateOver 0
                  3
                  ((+) 1)
                  2
                  (\x -> x * x)

    counter -- 256
-}
iterateOver : Int -> Int -> (Int -> Int) -> state -> (state -> state) -> state
iterateOver = Native.Loop.iterateOver
