{-# LANGUAGE ForeignFunctionInterface, JavaScriptFFI, CPP, EmptyDataDecls #-}

module JSUtils where

import GHCJS.Types
import GHCJS.DOM.Types
import GHCJS.Foreign
import Control.Applicative
import qualified JavaScript.JQuery as J
import Unsafe.Coerce

data Regex = Regex (JSRef Regex)

unRegex :: Regex -> JSRef Regex
unRegex (Regex r) = r
{-# INLINE unRegex #-}

documentURL :: (IsDocument doc, FromJSString res) => doc -> IO res
documentURL doc = fromJSString <$> js_documentURL (unDocument (toDocument doc))
{-# INLINE documentURL #-}

toDOMEvent :: J.Event -> Event
toDOMEvent = unsafeCoerce
{-# INLINE toDOMEvent #-}

jqCb :: (Event -> IO ()) -> (J.Event -> IO ())
jqCb f e = f (toDOMEvent e)
{-# INLINE jqCb #-}

regex :: ToJSString s => s -> Regex
regex r = Regex $ js_regex (toJSString r)
{-# INLINE regex #-}

stringMatch :: (ToJSString s, FromJSString r) => Regex -> s -> [r]
stringMatch r s = fmap (fromJSString . castRef) . fromPureArray $ js_stringMatch (toJSString s) (unRegex r)
{-# INLINE stringMatch #-}

(=~) :: String -> String -> [String]
s =~ p = stringMatch (regex p) s
{-# INLINE (=~) #-}

fromPureArray :: JSArray a -> [JSRef a]
fromPureArray a =
  let l = js_pureLength a
      go i | i < l     = js_pureIndex i a : go (i+1)
           | otherwise = []
  in go 0
{-# INLINE fromPureArray #-}

#ifdef __GHCJS__
foreign import javascript unsafe "Math.random()" mathRandom :: IO Double
foreign import javascript unsafe "document[\"URL\"]" js_documentURL :: JSRef Document -> IO JSString
foreign import javascript unsafe "new RegExp($1)" js_regex :: JSString -> JSRef Regex
foreign import javascript unsafe "$1.match($2)" js_stringMatch :: JSString -> JSRef Regex -> JSArray JSString
foreign import javascript unsafe "$1.length" js_pureLength :: JSArray a -> Int
foreign import javascript unsafe "$2[$1]" js_pureIndex :: Int -> JSArray a -> JSRef a
#else
mathRandom = error "mathRandom: only available in JavaScript"
js_documentURL = error "js_documentURL: only available in JavaScript"
js_regex = error "js_regex: only available in JavaScript"
js_stringMatch = error "js_stringMatch: only available in JavaScript"
js_pureLength = error "js_pureLength: only available in JavaScript"
js_pureIndex = error "js_pureIndex: only available in JavaScript"
#endif