{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}

module App.Server where

import qualified Data.Text as T
import           Servant

type DatesApi = Get '[ JSON] T.Text

datesApi :: Proxy DatesApi
datesApi = Proxy

server :: Server DatesApi
server = return "Hello, world."

app :: Application
app = serve datesApi server
