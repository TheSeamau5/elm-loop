Elm.Native.Loop = Elm.Native.Loop || {};
Elm.Native.Loop.make = function(localRuntime){

  localRuntime.Native = localRuntime.Native || {};
  localRuntime.Native.Loop = localRuntime.Native.Loop || {};

  if (localRuntime.Native.Loop.values){
    return localRuntime.Native.Loop.values;
  }

  var clone = function(obj) {
    if(obj == null || typeof(obj) != 'object')
        return obj;

    var temp = obj.constructor();

    for(var key in obj) {
        if(obj.hasOwnProperty(key)) {
            temp[key] = clone(obj[key]);
        }
    }
    return temp;
  };

  var Loop = {};

  Loop.loopWhile = function Loop_loop(condition, initialState, updater){
    var tempState = clone(initialState);

    while (condition(tempState) === true){
      tempState = updater(tempState);
    }

    return tempState;
  };

  Loop.loopUntil = function Loop_loop(condition, initialState, updater){
    var tempState = clone(initialState);

    while (condition(tempState) === false){
      tempState = updater(tempState);
    }

    return tempState;
  };

  Loop.loopWhileWithResult = function Loop_loopWithResult(condition, initialState, updater, result){
    var tempState = clone(initialState);

    while (condition(tempState) === true){
      tempState = updater(tempState);
    }

    return result(tempState);
  };

  Loop.loopUntilWithResult = function Loop_loopWithResult(condition, initialState, updater, result){
    var tempState = clone(initialState);

    while (condition(tempState) === false){
      tempState = updater(tempState);
    }

    return result(tempState);
  };

  Loop.iterate = function Loop_iterate(maxIteration, initialState, updater){
    if (maxIteration <= 0){
      return initialState;
    }

    var tempState = clone(initialState);
    var i = 0;

    for (i = 0; i < maxIteration; i++){
      tempState = updater(tempState);
    }

    return tempState;
  };

  Loop.iterateOver = function Loop_iterateOver(iterationStart, iterationEnd, stepFunction, initialState, updater){

    if (iterationStart === iterationEnd){
      return initialState;
    }

    var tempState = clone(initialState);

    var iterationIsForward = iterationStart < iterationEnd;

    var iterationHasNotEnded = function(i){
      if (iterationIsForward === true){
        return i < iterationEnd;
      }else{
        return i > iterationEnd;
      }
    };

    for (i = iterationStart; iterationHasNotEnded(i); i = stepFunction(i)){
      tempState = updater(tempState);
    }

    return tempState;

  };

  return {
    loopWhile : F3(Loop.loopWhile),
    loopWhileWithResult : F4(Loop.loopWhileWithResult),
    loopUntil : F3(Loop.loopUntil),
    loopUntilWithResult : F4(Loop.loopUntilWithResult),
    iterate : F3(Loop.iterate),
    iterateOver : F5(Loop.iterateOver)
  };
};
