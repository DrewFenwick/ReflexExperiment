{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies     #-}

module App (app) where

import Reflex.Host.Basic
import Control.Concurrent (forkIO)
import Control.Concurrent.MVar

import Network
import Gui

app :: IO ()
app = do
  triggers <- newEmptyMVar :: IO (MVar GuiTriggers)
  forkIO $ basicHostForever $ network triggers
  gui =<< takeMVar triggers