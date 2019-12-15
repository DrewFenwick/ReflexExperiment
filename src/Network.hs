{-# language TypeFamilies     #-}
{-# language FlexibleContexts #-}

module Network (network) where

import Reflex
import Reflex.Host.Basic
import Control.Concurrent.MVar
import Control.Monad.IO.Class
import Control.Monad.Fix (MonadFix)

import Gui (GuiTriggers(..))

myNetwork
  :: (Reflex t, MonadHold t m, MonadFix m)
  => Event t ()
  -> m (Dynamic t Int)
myNetwork = count

network ::  (BasicGuestConstraints t m) => MVar GuiTriggers -> BasicGuest t m ()
network guiTriggers = do
  (clickEvent, clickTrigger) <- newTriggerEvent 
  liftIO . putMVar guiTriggers $ GuiTriggers (clickTrigger ())

  clickCount <- myNetwork clickEvent

  performEvent_ . fmap (liftIO . putStrLn . show) . updated $ clickCount
  pure ()