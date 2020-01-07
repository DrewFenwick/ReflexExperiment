{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies     #-}

module App (app) where

import Reflex.Host.Basic
import Control.Concurrent (forkIO)
import Control.Concurrent.MVar
import qualified GI.Gtk as Gtk (main)

import Network
import qualified Gui
import Gui (GuiTriggers, GuiElements)

app :: IO ()
app = do
  elements <- Gui.mkElements
  triggers <- newEmptyMVar :: IO (MVar GuiTriggers)
  forkIO $ basicHostForever $ network (Gui.mkGuiActions elements) triggers
  Gui.setupGui elements =<< readMVar triggers
  Gtk.main