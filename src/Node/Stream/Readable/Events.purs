module Node.Stream.Readable.Events where

import Prelude

import Data.Foreign (Foreign)
import Effect (Effect)
import Node.Buffer (Buffer)
import Node.Events.Event (Event(..))
import Node.Events.EventEmitter (on')
import Node.Stream.Readable (class Readable)

close :: forall readable. Readable readable =>
    Event readable (Effect Unit)
close = Event "close"

data' :: forall readable. Readable readable =>
    Event readable (Foreign -> Effect Unit)
data' = Event "data"

end :: forall readable. Readable readable =>
    Event readable (Effect Unit)
end = Event "end"

readable :: forall readable. Readable readable =>
    Event readable (Effect Unit)
readable = Event "readable"
