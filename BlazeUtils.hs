{-# LANGUAGE OverloadedStrings #-}

module BlazeUtils where

import Prelude ()
import Text.Blaze
import Text.Blaze.Html
import Text.Blaze.Internal
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

alink :: AttributeValue  -- ^ Attribute value.
         -> Attribute       -- ^ Resulting attribute.
alink = attribute "alink" " alink=\""

vlink :: AttributeValue  -- ^ Attribute value.
         -> Attribute       -- ^ Resulting attribute.
vlink = attribute "vlink" " vlink=\""

link :: AttributeValue  -- ^ Attribute value.
         -> Attribute       -- ^ Resulting attribute.
link = attribute "link" " link=\""

wrap :: Html -> Html
wrap = H.span ! A.style "white-space: pre-wrap"

h :: Html -> Html
h = Parent "h" "<h" "</h>"