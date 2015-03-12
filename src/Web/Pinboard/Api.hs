{-# LANGUAGE OverloadedStrings #-}
-------------------------------------------
-- |
-- Module      : Web.Pinboard.Api
-- Copyright   : (c) Jon Schoning, 2015
-- Maintainer  : jonschoning@gmail.com
-- Stability   : experimental
-- Portability : POSIX
--
-- < https://pinboard.in/api/ >

module Web.Pinboard.Api
    ( 
      Tag,
      Count,
      getPostsRecent
    ) where

import           Web.Pinboard.Client.Internal (pinboardJson)
import           Web.Pinboard.Client.Types    (Pinboard, PinboardRequest (..))
import           Web.Pinboard.Client.Util     (toText, getParams)
import           Web.Pinboard.ApiTypes         
import           Control.Applicative          ((<$>))
import           Data.Text                    (Text, intercalate)
                                            
------------------------------------------------------------------------------
                                            
type Tag = Text
type Count = Int

-- | Returns a list of the user's most recent posts, filtered by tag.
getPostsRecent 
  :: Maybe [Tag] -- ^ filter by up to three tags
  -> Maybe Count -- ^ number of results to return. Default is 15, max is 100  
  -> Pinboard Posts
getPostsRecent tags count = pinboardJson (PinboardRequest url params)
  where 
    url = "posts/recent" 
    params = getParams 
          [ ("tag", intercalate "," <$> tags)
          , ("count", toText <$> count) ]
