{-# LANGUAGE OverloadedStrings #-}

module Temp 
    ( run
    ) where

import Test.WebDriver
import Data.Text
import Test.WebDriver.Commands.Wait (waitUntil)
import Test.WebDriver.Session (WDSessionState(getSession))
import Test.WebDriver.JSON (ignoreReturn)
import Test.WebDriver.Common.Keys (arrowDown)
import Control.Monad (replicateM_)
import Control.Monad.Loops
import qualified System.IO as SIO

firefoxConfig :: WDConfig
firefoxConfig = defaultConfig 

chromeConfig :: WDConfig
chromeConfig = useBrowser chr defaultConfig
  { wdHost = "0.0.0.0", wdPort = 4444, wdHTTPRetryCount = 50 }
  where chr = chrome
run = runSession chromeConfig  $ do
  openPage "https://www.reddit.com/r/rust/comments/rkjf0e/hey_rustaceans_got_an_easy_question_ask_here/" 
  body <- findElem $ ByTag "body"
  replicateM_ 10000 (sendKeys "arrowDown" body)
  -- whileM_ 
  getSource


