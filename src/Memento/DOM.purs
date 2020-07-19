module Memento.DOM (getRootHTMLElement) where

import Prelude

import Data.Maybe
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception 
import Web.HTML (HTMLElement)
import Web.HTML (window) as HTML
import Web.HTML.HTMLElement as HTMLElement
import Web.HTML.Window (document) as HTML.Window
import Web.HTML.HTMLDocument (toNonElementParentNode) as HTML
import Web.DOM.NonElementParentNode (getElementById) as DOM

liftMaybeM :: forall m a. MonadEffect m => Error -> m (Maybe a) -> m a
liftMaybeM e m = m >>= maybe (liftEffect $ throwException e) pure
  
getRootHTMLElement :: Effect HTMLElement
getRootHTMLElement = (f <=< HTML.Window.document) =<< HTML.window
  where f =   liftMaybeM (error "#root element not found")
          <<< map (flip bind HTMLElement.fromElement)
          <<< DOM.getElementById "root"
          <<< HTML.toNonElementParentNode
