{-# language TypeFamilies     #-}
{-# language FlexibleContexts #-}
{-# language RecordWildCards  #-}

module Network (network) where

import Reflex
import Reflex.Host.Basic
import Control.Concurrent.MVar
import Control.Monad.IO.Class
import Control.Monad.Fix (MonadFix)
import Data.Text (pack)

import Gui (GuiTriggers(..), GuiActions(..))

myNetwork
  :: (Reflex t, MonadHold t m, MonadFix m)
  => Event t ()
  -> m (Dynamic t Int)
myNetwork = count

network ::  (BasicGuestConstraints t m) => GuiActions -> MVar GuiTriggers -> BasicGuest t m ()
network GuiActions{..} guiTriggers = do
  (clickEvent, clickTrigger) <- newTriggerEvent 
  liftIO . putMVar guiTriggers $ GuiTriggers (clickTrigger ())

  clickCount <- count clickEvent

  performEvent_ . fmap (liftIO . retitleButton . pack . show) . updated $ clickCount
  pure ()