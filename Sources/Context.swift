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
import LibZMQ

extension ZMQ {

    public class Context {
        var handle : UnsafeMutableRawPointer?

        public init() throws {
            let contextHandle = zmq_ctx_new()
            if contextHandle == nil {
                throw ZMQError.last
            }

            handle = contextHandle
        }

        deinit {
            do {
                try terminate()
            } catch {
                print(error)
            }
        }

        /*
            Shutdown the current context without terminating the current context
         */
        public func shutdown() throws {
            guard handle != nil else {
                return
            }

            let result = zmq_ctx_shutdown(handle)
            if result == -1 {
                throw ZMQError.last
            } else {
                handle = nil
            }
        }

        /*
            Terminate the current context and block until all open sockets
            are closed or their linger period has expired
         */
        public func terminate() throws {
            guard handle != nil else {
                return
            }

            let result = zmq_ctx_term(handle)
            if result == -1 {
                throw ZMQError.last
            } else {
                handle = nil
            }
        }

        /*
            Returns a ZMQ socket with the type provided
         */
        public func socket(_ type : ZMQ.SocketType) throws -> Socket {
            return try Socket(context: self, type: type)
        }

        /*
            Returns the current context option value (private)
         */
        private func getOption(_ name : Int32) throws -> Int32 {
            let result = zmq_ctx_get(handle, name)
            if result == -1 {
                throw ZMQError.last
            }

            return result
        }

        /*
            Sets the current context option value (private)
         */
        private func setOption(_ name: Int32, _ value: Int32) throws {
            let result = zmq_ctx_set(handle, name, value)
            if result == -1 {
                throw ZMQError.last
            }
        }

        /*
            Returns the number of I/O threads for the current context

            Default value is 1 (read and write)
         */
        public func getIOThreads() throws -> Int {
            return try Int(getOption(ZMQ_IO_THREADS))
        }

        /*
            Sets the number of I/O threads for the current context

            Default value is 1 (read and write)
         */
        public func setIOThreads(_ value : Int = 1) throws {
            try setOption(ZMQ_IO_THREADS, Int32(value))
        }

        /*
            Sets the scheduling policy for I/O threads for the current context

            Default value is -1 (write only)
         */
        public func setThreadSchedulingPolicy(_ value : Int = -1) throws {
            try setOption(ZMQ_THREAD_SCHED_POLICY, Int32(value))
        }

        /*
            Sets the scheduling priority for I/O threads for the current context

            Default value is -1 (write only)
         */
        public func setThreadPriority(_ value : Int = -1) throws {
            try setOption(ZMQ_THREAD_PRIORITY, Int32(value))
        }

        /*
            Returns the maximum number of sockets associated with the current
            context

            Default value is 1024 (read/write)
         */
        public func getMaxSockets() throws -> Int {
            return try Int(getOption(ZMQ_MAX_SOCKETS))
        }

        /*
            Sets the maximum number of sockets associated with the current
            context

            Default value is 1024 (read/write)
         */
        public func setMaxSockets(_ value : Int = 1024) throws {
            try setOption(ZMQ_MAX_SOCKETS, Int32(value))
        }

        /*
            Returns whether the IPV6 is enabled or not for the current context

            Default value is false (read/write)
         */
        public func isIPV6Enabled() throws -> Bool {
            return try getOption(ZMQ_IPV6) == 1
        }

        /*
            Sets whether the IPV6 is enabled or not for the current context

            Default value is false (read/write)
         */
        public func setIPV6Enabled(_ enabled : Bool = false) throws {
            try setOption(ZMQ_IPV6, enabled ? 1 : 0)
        }

        /*
            The maximum socket limit associated with the current context

            Default value: (read only)
         */
        public func getSocketLimit() throws -> Int {
            return try Int(getOption(ZMQ_SOCKET_LIMIT))
        }

    }

}
