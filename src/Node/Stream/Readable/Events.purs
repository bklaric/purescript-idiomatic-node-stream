module Node.Stream.Readable.Events where

import Prelude

import Effect (Effect)
import Data.Foreign (Foreign)
import Node.Buffer (Buffer)
import Node.Events.Event (Event(..))
import Node.Stream.Readable (class Readable)

close :: forall readable. Readable readable =>
    Event readable (Effect Unit)
close = Event "close"

data' :: forall readable. Readable readable =>
    Event readable (Foreign -> Effect Unit)
data' = Event "data"

dataBuffer :: forall readable. Readable readable =>
    Event readable (Buffer -> Effect Unit)
dataBuffer = Event "data"

dataString :: forall readable. Readable readable =>
    Event readable (String -> Effect Unit)
dataString = Event "data"

end :: forall readable. Readable readable =>
    Event readable (Effect Unit)
end = Event "end"

readable :: forall readable. Readable readable =>
    Event readable (Effect Unit)
readable = Event "readable"
