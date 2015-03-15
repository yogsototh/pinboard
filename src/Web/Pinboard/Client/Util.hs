{-# LANGUAGE OverloadedStrings #-}
-- |
-- Module      : Web.Pinboard.Client.Util
-- Copyright   : (c) Jon Schoning, 2015
-- Maintainer  : jonschoning@gmail.com
-- Stability   : experimental
-- Portability : POSIX
module Web.Pinboard.Client.Util
    ( 
      mkConfig
    , fromApiToken
    , paramsToByteString
    , toText
    , toTextLower
    , (</>)
    , paramToName
    , paramToText
    , encodeParams
    ) where

import           Data.Monoid           (Monoid, mconcat, mempty, (<>))
import           Data.String           (IsString)
import           Data.ByteString       (ByteString)
import           Data.Text             (Text)
import qualified Data.Text             as T
import qualified Data.Text.Encoding    as T
import           Data.Data (toConstr)
import           Web.Pinboard.Client.Types (PinboardConfig (..), Param (..), ParamsBS)

------------------------------------------------------------------------------

mkConfig :: PinboardConfig
mkConfig = PinboardConfig { debug = False, apiToken = mempty }

fromApiToken :: ByteString -> PinboardConfig
fromApiToken token = PinboardConfig { debug = False, apiToken = token }

------------------------------------------------------------------------------
-- | Conversion from a `Show` constrained type to `Text`
toText
    :: Show a
    => a    
    -> Text 
toText = T.pack . show

------------------------------------------------------------------------------
-- | Conversion from a `Show` constrained type to lowercase `Text`
toTextLower
    :: Show a
    => a    
    -> Text 
toTextLower = T.toLower . T.pack . show

------------------------------------------------------------------------------
-- | Conversion of a key value pair to a query parameterized string
paramsToByteString
    :: (Monoid m, IsString m)
    => [(m, m)]
    -> m
paramsToByteString []           = mempty
paramsToByteString [(x,y)] = x <> "=" <> y
paramsToByteString ((x,y) : xs) =
    mconcat [ x, "=", y, "&" ] <> paramsToByteString xs

-- | Retrieve and encode the optional parameters
encodeParams :: [Param] -> ParamsBS
encodeParams xs = do 
  x <- xs 
  return ((T.encodeUtf8 . paramToName) x, (T.encodeUtf8 . paramToText) x)

paramToText :: Param -> Text
paramToText (Tag a) = a
paramToText (Old a) = a
paramToText (New a) = a
paramToText (Format a) = a
paramToText (Count a) = toText a
paramToText (Url a) = a

paramToName :: Param -> Text
paramToName = toTextLower . toConstr
------------------------------------------------------------------------------
-- | Forward slash interspersion on `Monoid` and `IsString`
-- constrained types
(</>)
    :: (Monoid m, IsString m)
    => m
    -> m
    -> m
m1 </> m2 = m1 <> "/" <> m2
