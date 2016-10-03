/*
MIT License

Copyright (c) 2016 Ahmad M. Zawawi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

// For now
import CZeroMQ

extension ZMQ {

    public enum SocketType : Int32 {
        case req
        case rep
        case router
        case dealer
    }

}

extension ZMQ.SocketType {
    public var rawValue: Int32 {
        switch self {
            case .req:
                return ZMQ_REQ
            case .rep:
                return ZMQ_REP
            case .router:
                return ZMQ_ROUTER
            case .dealer:
                return ZMQ_DEALER
        }
    }
}
