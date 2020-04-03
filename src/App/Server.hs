{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeOperators         #-}

module App.Server where

import           Control.Monad.IO.Class ( liftIO )
import qualified Data.ByteString.Lazy   as BS
import qualified Data.Text              as T
import           Network.HTTP.Media     ( (//), (/:) )
import           Servant

data HTML

instance Accept HTML where
  contentType _ = "text" // "html" /: ("charset", "utf-8")

instance MimeRender HTML BS.ByteString where
  mimeRender _ bs = bs

type DatesApi = Get '[ HTML] BS.ByteString :<|> "static" :> Raw

datesApi :: Proxy DatesApi
datesApi = Proxy

server :: BS.ByteString -> Server DatesApi
server top = liftIO (return top) :<|> serveDirectoryWebApp "./dist/static"

app :: BS.ByteString -> Application
app = serve datesApi . server
