{-# LANGUAGE ForeignFunctionInterface, JavaScriptFFI, CPP, EmptyDataDecls #-}

module JSUtils where

import GHCJS.Types
import GHCJS.DOM.Types (Element(..))
import GHCJS.Foreign

#ifdef __GHCJS__
foreign import javascript unsafe "Math.random()" mathRandom :: IO Double
#else
mathRandom :: IO Double
mathRandom = error "mathRandom: only available in JavaScript"
#endif