module Node.Stream.Readable
    ( class Readable
    , readableHighWaterMark
    , readableLength
    , isPaused
    , pause
    , read
    , resume
    , pipe
    , unpipe
    , setEncoding
    , unshift
    , destroy
    , defaultReadableHighWaterMark
    , defaultReadableLength
    , defaultIsPaused
    , defaultPause
    , defaultRead
    , defaultResume
    , defaultPipe
    , defaultUnpipe
    , defaultSetEncoding
    , defaultUnshift
    , defaultDestroy
    , read_
    , readBuffer
    , readBuffer_
    , readString
    , readString_
    , pipe_
    , unpipe_
    ) where

import Prelude

import Control.Monad.Effect (Effect)
import Control.Monad.Effect.Exception (Error)
import Data.Foreign (Foreign)
import Data.Nullable (Nullable)
import Node.Buffer (Buffer)
import Node.Encoding (Encoding, toNodeString)
import Node.Events.EventEmitter as EE
import Node.Stream.Writable as W
import Unsafe.Coerce (unsafeCoerce)

class EE.EventEmitter readable <= Readable readable where
    readableHighWaterMark :: readable -> Effect Int
    readableLength :: readable -> Effect Int
    isPaused :: readable -> Effect Boolean
    pause :: readable -> Effect readable
    read :: Int -> readable -> Effect (Nullable Foreign)
    resume :: readable -> Effect readable
    pipe :: forall writable. W.Writable writable =>
        writable -> Boolean -> readable -> Effect writable
    unpipe :: forall writable. W.Writable writable =>
        writable -> readable -> Effect Unit
    setEncoding :: Encoding -> readable -> Effect readable
    unshift :: Foreign -> readable -> Effect Unit
    destroy :: Error -> readable -> Effect readable

foreign import defaultReadableHighWaterMark :: forall readable.
    readable -> Effect Int

foreign import defaultReadableLength :: forall readable. readable -> Effect Int

foreign import defaultIsPaused :: forall readable. readable -> Effect Boolean

foreign import defaultPause :: forall readable. readable -> Effect readable

foreign import defaultRead :: forall readable.
    Int -> readable -> Effect (Nullable Foreign)

foreign import defaultResume :: forall readable. readable -> Effect readable

foreign import defaultPipe :: forall readable writable. W.Writable writable =>
    writable -> Boolean -> readable -> Effect writable

foreign import defaultUnpipe :: forall readable writable. W.Writable writable =>
    writable -> readable -> Effect Unit

foreign import defaultSetEncodingImpl :: forall readable.
    String -> readable -> Effect readable

defaultSetEncoding :: forall readable. Encoding -> readable -> Effect readable
defaultSetEncoding encoding readable =
    defaultSetEncodingImpl (toNodeString encoding) readable

foreign import defaultUnshift :: forall readable.
    Foreign -> readable -> Effect Unit

foreign import defaultDestroy :: forall readable.
    Error -> readable -> Effect readable

read_ :: forall readable. Readable readable =>
    readable -> Effect (Nullable Foreign)
read_ readable = read W.undefined readable

readBuffer :: forall readable. Readable readable =>
    Int -> readable -> Effect (Nullable Buffer)
readBuffer size readable = unsafeCoerce $ read size readable

readBuffer_ :: forall readable. Readable readable =>
    readable -> Effect (Nullable Buffer)
readBuffer_ readable = readBuffer W.undefined readable

readString :: forall readable. Readable readable =>
    Int -> readable -> Effect (Nullable String)
readString size readable = unsafeCoerce $ read size readable

readString_ :: forall readable. Readable readable =>
    readable -> Effect (Nullable String)
readString_ readable = readString W.undefined readable

pipe_ :: forall readable writable.
    Readable readable => W.Writable writable =>
    writable -> readable -> Effect writable
pipe_ writable readable = pipe writable true readable

-- Flipping the typechecker off.
data UndefinedWritable

instance eventEmitterUndefinedWritable ::
    EE.EventEmitter UndefinedWritable where
    on = EE.defaultOn
    once = EE.defaultOnce
    prependListener = EE.defaultPrependListener
    prependOnceListener = EE.defaultPrependOnceListener
    removeListener = EE.defaultRemoveListener
    removeAllListeners = EE.defaultRemoveAllListeners
    emit = EE.defaultEmit
    listeners = EE.defaultListeners
    listenerCount = EE.defaultListenerCount
    getMaxListeners = EE.defaultGetMaxListeners
    setMaxListeners = EE.defaultSetMaxListeners
    eventNames = EE.defaultEventNames

instance writableUndefinedWritable :: W.Writable UndefinedWritable where
    writableHighWaterMark = W.defaultWritableHighWaterMark
    writableLength = W.defaultWritableLength
    cork = W.defaultCork
    uncork = W.defaultUncork
    write = W.defaultWrite
    end = W.defaultEnd
    destroy = W.defaultDestroy

unpipe_ :: forall readable. Readable readable => readable -> Effect Unit
unpipe_ readable = unpipe (W.undefined :: UndefinedWritable) readable
