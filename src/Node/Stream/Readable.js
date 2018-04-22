"use strict";

exports.defaultReadableHighWaterMark = function (readable) {
    return function () {
        return readable.readableHighWaterMark
    }
}

exports.defaultReadableLength = function (readable) {
    return function () {
        return readable.readableLength
    }
}

exports.defaultIsPaused = function (readable) {
    return function () {
        return readable.isPaused()
    }
}

exports.defaultReadImpl = function (size) {
    return function (readable) {
        return function () {
            return readable.read(size)
        }
    }
}

exports.defaultResume = function (readable) {
    return function () {
        return readable.resume()
    }
}

exports.defaultPause = function (readable) {
    return function () {
        return readable.pause()
    }
}

exports.defaultPipe = function (writableClass) {
    return function (writable) {
        return function (end) {
            return function (readable) {
                return function () {
                    return readable.pipe(writable, end)
                }
            }
        }
    }
}

exports.defaultUnpipe = function (writableClass) {
    return function (writable) {
        return function (readable) {
            return function () {
                readable.unpipe(writable)
            }
        }
    }
}

exports.defaultSetEncodingImpl = function (encoding) {
    return function (readable) {
        return function () {
            return readable.setEncoding(encoding)
        }
    }
}

exports.defaultUnshift = function (chunk) {
    return function (readable) {
        return function () {
            readable.unshift(chunk)
        }
    }
}

exports.defaultDestroy = function (error) {
    return function (readable) {
        return function () {
            readable.destroy(error)
        }
    }
}
