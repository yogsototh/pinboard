__v0.9.11__

add logging

add option to delay between requests (requestDelayMills)

__v0.9.10__

avoid pre-lifting IO into MonadIO

extend aeson upper-bound

__v0.9.9__

generalize (Either PinboardError a) to (MonadErrorPinboard)

__v0.9.8__

use safe-exception

avoid use of 'error' to communicate failure when parsing json

includes a few changes to the types/api in Pinboard.Client

__v0.9.7__

add http-client-0.5.0 support

add PVP bounds

__v0.9.6__

add http-client bound

__v0.9.5__

add JSON roundtrip tests

__v0.9.4__

derive generic

__v0.9.3__

Add lenses

__v0.9.2__

Make data fields strict

__v0.9.1__

rename field: postToread -> postToRead

__v0.9.0__

refactored Client.hs to simplify parameters

promote types under .Client subtree to top-level

__v0.8.5__

replace Pinboard stack with PinboardT transfomer (use mtl style constraints instead of a fixed monad transformer stack)

__v0.7.5__

replacing/removing io-streams in favor of http-client

__v0.6.5__

compatability with both time < 1.5 and time >= 1.5

__v0.6.4__

add ability to update a post directly from a Post record (save an existing post)

__v0.6.3__

add ToJson instances
add pretty print function
