{-# LANGUAGE ForeignFunctionInterface, JavaScriptFFI, CPP, EmptyDataDecls #-}

module JSUtils where

import GHCJS.Types
import GHCJS.DOM.Types
import GHCJS.Foreign
import Control.Applicative
import qualified JavaScript.JQuery as J
import Unsafe.Coerce

documentURL :: (IsDocument doc, FromJSString res) => doc -> IO res
documentURL doc = fromJSString <$> js_documentURL (unDocument (toDocument doc))

toDOMEvent :: J.Event -> Event
toDOMEvent = unsafeCoerce

jqCb :: (Event -> IO ()) -> (J.Event -> IO ())
jqCb f e = f (toDOMEvent e)

#ifdef __GHCJS__
foreign import javascript unsafe "Math.random()" mathRandom :: IO Double
foreign import javascript unsafe "document[\"URL\"]" js_documentURL :: JSRef Document -> IO JSString
#else
mathRandom = error "mathRandom: only available in JavaScript"
js_documentURL = error "documentURL: only available in JavaScript"
#endif