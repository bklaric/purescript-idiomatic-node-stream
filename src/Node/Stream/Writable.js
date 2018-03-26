"use strict";

exports.undefined = undefined

exports.defaultWritableHighWaterMark = function (stream) {
    return stream.writableHighWaterMark
}

exports.defaultWritableLength = function (stream) {
    return stream.writableLength
}

exports.defaultCork = function (stream) {
    return function () {
        stream.cork()
    }
}

exports.defaultUncork = function (stream) {
    return function () {
        stream.uncork()
    }
}

exports.defaultWrite = function (toWrite) {
    return function (callback) {
        return function (stream) {
            return function () {
                return stream.write(toWrite, callback)
            }
        }
    }
}

exports.defaultEnd = function (toWrite) {
    return function (callback) {
        return function (stream) {
            return function () {
                return stream.end(toWrite, callback)
            }
        }
    }
}

exports.defaultDestroy = function (error) {
    return function (stream) {
        return function () {
            return stream.destroy(error)
        }
    }
}
